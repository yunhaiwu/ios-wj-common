//
//  IWJViewModel.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  ViewModel 接口
 */
@protocol IWJViewModel <NSObject>

/**
 *  当前界面是否为活跃界面
 */
@property (nonatomic, assign) BOOL wjActive;

- (void)wjViewWillAppear;

- (void)wjViewDidAppear;

- (void)wjViewWillDisappear;

- (void)wjViewDidDisappear;

/**
 *  内存警告
 */
- (void)wjDidReceiveMemoryWarning;

@end
