//
//  BaseWJTabBarController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/6.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJTabBarController.h"

@implementation BaseWJTabBarController

+ (instancetype)wj_instance {
    return [[self alloc] init];;
}

-(BOOL)shouldAutorotate {
    if (self.selectedViewController) {
        return [self.selectedViewController shouldAutorotate];
    }
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.selectedViewController) {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.selectedViewController) {
        return [self.selectedViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

@end
