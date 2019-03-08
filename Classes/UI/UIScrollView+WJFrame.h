//
//  UIScrollView+WJFrame.h
//  WJCommon-master
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/7/4.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WJFrame)

/**
 *  contentSize.width
 */
@property(nonatomic, assign) CGFloat wjContentWidth;

/**
 *  contentSize.height
 */
@property(nonatomic, assign) CGFloat wjContentHeight;

/**
 *  contentOffset.x
 */
@property(nonatomic, assign) CGFloat wjContentOffsetX;

/**
 *  contentOffset.y
 */
@property(nonatomic, assign) CGFloat wjContentOffsetY;

/**
 *  contentInset.top
 */
@property(nonatomic, assign) CGFloat wjContentInsetTop;

/**
 *  contentInset.bottom
 */
@property(nonatomic, assign) CGFloat wjContentInsetBottom;

/**
 *  contentInset.left
 */
@property(nonatomic, assign) CGFloat wjContentInsetLeft;

/**
 *  contentInset.right
 */
@property(nonatomic, assign) CGFloat wjContentInsetRight;

@end
