//
//  UIScrollView+WJFrame.m
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

#import "UIScrollView+WJFrame.h"

@implementation UIScrollView (WJFrame)

-(CGFloat)wjContentWidth {
    return self.contentSize.width;
}

-(void)setWjContentWidth:(CGFloat)wjContentWidth {
    if (self.contentSize.width == wjContentWidth) return;
    self.contentSize = CGSizeMake(wjContentWidth, self.contentSize.height);
}

-(CGFloat)wjContentHeight {
    return self.contentSize.height;
}

-(void)setWjContentHeight:(CGFloat)wjContentHeight {
    if (self.contentSize.height == wjContentHeight) return;
    self.contentSize = CGSizeMake(self.contentSize.width, wjContentHeight);
}

-(CGFloat)wjContentOffsetX {
    return self.contentOffset.x;
}

-(void)setWjContentOffsetX:(CGFloat)wjContentOffsetX {
    if (self.contentOffset.x == wjContentOffsetX) return;
    self.contentOffset = CGPointMake(wjContentOffsetX, self.contentOffset.y);
}

-(CGFloat)wjContentOffsetY {
    return self.contentOffset.y;
}

-(void)setWjContentOffsetY:(CGFloat)wjContentOffsetY {
    if (self.contentOffset.y == wjContentOffsetY) return;
    self.contentOffset = CGPointMake(self.contentOffset.x, wjContentOffsetY);
}

-(CGFloat)wjContentInsetTop {
    return self.contentInset.top;
}

-(void)setWjContentInsetTop:(CGFloat)wjContentInsetTop {
    if (self.contentInset.top == wjContentInsetTop) return;
    self.contentInset = UIEdgeInsetsMake(wjContentInsetTop, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
}

-(CGFloat)wjContentInsetBottom {
    return self.contentInset.bottom;
}

-(void)setWjContentInsetBottom:(CGFloat)wjContentInsetBottom {
    if (self.contentInset.bottom == wjContentInsetBottom) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, wjContentInsetBottom, self.contentInset.right);
}

-(CGFloat)wjContentInsetLeft {
    return self.contentInset.left;
}

-(void)setWjContentInsetLeft:(CGFloat)wjContentInsetLeft {
    if (self.contentInset.left == wjContentInsetLeft) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, wjContentInsetLeft, self.contentInset.bottom, self.contentInset.right);
}

-(CGFloat)wjContentInsetRight {
    return self.contentInset.right;
}

-(void)setWjContentInsetRight:(CGFloat)wjContentInsetRight {
    if (self.contentInset.right == wjContentInsetRight) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom, wjContentInsetRight);
}


@end
