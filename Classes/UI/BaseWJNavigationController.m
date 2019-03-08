//
//  BaseWJNavigationController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJNavigationController.h"

@implementation BaseWJNavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  默认隐藏导航栏
     */
    [self setNavigationBarHidden:YES];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
#endif
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

+(instancetype)wjInstance {
    BaseWJNavigationController *instance = [[self alloc] init];
    return instance;
}

+(instancetype)wjInstance:(UIViewController*) rootViewController {
    if (rootViewController) {
        BaseWJNavigationController *instance = [[self alloc] initWithRootViewController:rootViewController];
        return instance;
    }
    return [self wjInstance];
}

-(BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
