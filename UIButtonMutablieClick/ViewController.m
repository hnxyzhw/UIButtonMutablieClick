//
//  ViewController.m
//  UIButtonMutablieClick
//
//  Created by andson-zhw on 16/8/3.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+ZHW.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.button.zhw_ignoreEvent = NO;
    self.button.zhw_acceptEventInterval = 3.0;
}
- (IBAction)runtimeAction:(UIButton *)sender {
    NSLog(@"----run click");
    [UIView animateWithDuration:3 animations:^{
        
        self.colorView.center = CGPointMake(200, 500);
        
    } completion:^(BOOL finished) {
        
        self.colorView.center = CGPointMake(95, 85);
        
    }];
}
- (IBAction)buttonAction:(UIButton *)sender {
    NSLog(@"------comm click");
    [UIView animateWithDuration:3 animations:^{
        
        self.colorView.center = CGPointMake(200, 500);
        
    } completion:^(BOOL finished) {
        
        self.colorView.center = CGPointMake(95, 85);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
