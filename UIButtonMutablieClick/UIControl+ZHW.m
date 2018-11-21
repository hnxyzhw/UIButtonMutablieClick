//
//  UIControl+ZHW.m
//  UIButtonMutablieClick
//
//  Created by andson-zhw on 16/8/3.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "UIControl+ZHW.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic, assign) NSTimeInterval zhw_acceptEventTime;

@end

@implementation UIControl (ZHW)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)zhw_acceptEventInterval {
    
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
    
}

- (void)setZhw_acceptEventInterval:(NSTimeInterval)zhw_acceptEventInterval {
    
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(zhw_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)zhw_ignoreEvent {
    
    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];
    
}

- (void)setZhw_ignoreEvent:(BOOL)zhw_ignoreEvent {
    
    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(zhw_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSTimeInterval )zhw_acceptEventTime {
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setZhw_acceptEventTime:(NSTimeInterval)zhw_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(zhw_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    SEL aSEL = @selector(sendAction:to:forEvent:);
    
    Method b = class_getInstanceMethod(self, @selector(__zhw_sendAction:to:forEvent:));
    
    SEL bSEL = @selector(__zhw_sendAction:to:forEvent:);
    
    //添加方法 语法：BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 若添加成功则返回No
    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
    BOOL didAddMethod = class_addMethod(self, aSEL, method_getImplementation(b), method_getTypeEncoding(b));

    //如果系统中该方法已经存在了，则替换系统的方法  语法：IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
    if (didAddMethod) {
        class_replaceMethod(self, bSEL, method_getImplementation(a), method_getTypeEncoding(a));
    }else{
        method_exchangeImplementations(a, b);
    }
    
}

- (void)__zhw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.zhw_ignoreEvent) return;
    
    if (self.zhw_acceptEventInterval > 0) {
        
        // 是否小于设定的时间间隔
        BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.zhw_acceptEventTime >= self.zhw_acceptEventInterval);
        
        // 更新上一次点击时间戳
        self.zhw_acceptEventTime = NSDate.date.timeIntervalSince1970;
        
        // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
        if (needSendAction) {
            [self __zhw_sendAction:action to:target forEvent:event];
        }
        
        return;
    }
    
    [self __zhw_sendAction:action to:target forEvent:event];
    
}

@end
