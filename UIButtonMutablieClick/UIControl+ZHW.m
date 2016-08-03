//
//  UIControl+ZHW.m
//  UIButtonMutablieClick
//
//  Created by andson-zhw on 16/8/3.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "UIControl+ZHW.h"
#import <objc/runtime.h>




@implementation UIControl (ZHW)
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

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

+ (void)load {
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    Method b = class_getInstanceMethod(self, @selector(__zhw_sendAction:to:forEvent:));
    
    method_exchangeImplementations(a, b);
    
}

- (void)__zhw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.zhw_ignoreEvent) return;
    
    if (self.zhw_acceptEventInterval > 0) {
        
        self.zhw_ignoreEvent = YES;
        
        [self performSelector:@selector(setZhw_ignoreEvent:) withObject:@(NO) afterDelay:self.zhw_acceptEventInterval];
        
    }
    
    [self __zhw_sendAction:action to:target forEvent:event];
    
}

@end
