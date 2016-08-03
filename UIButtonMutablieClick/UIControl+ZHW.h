//
//  UIControl+ZHW.h
//  UIButtonMutablieClick
//
//  Created by andson-zhw on 16/8/3.
//  Copyright © 2016年 andson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZHW)
@property (nonatomic, assign) NSTimeInterval zhw_acceptEventInterval;//添加点击事件的间隔时间

@property (nonatomic, assign) BOOL zhw_ignoreEvent;//是否忽略点击事件,不响应点击事件

@end
