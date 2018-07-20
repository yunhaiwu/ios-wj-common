//
//  TestAlertContentView.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "TestAlertContentView.h"
#import "WJAlertView.h"

@interface TestAlertContentView ()

-(IBAction)btnExec:(id)sender;

@end

@implementation TestAlertContentView

-(void)btnExec:(id)sender {
    [self.containerView close:NO];
}

#pragma mark IWJAlertContentView
- (CGSize)contentViewSize {
    return CGSizeMake(280.0f, 200.0f);
}

- (CGFloat)backgroundAlpha {
    return 0.6f;
}

-(CGPoint)contentViewOffset {
    return CGPointMake(0, -20);
}

-(CGFloat)keyboardShowContentViewOffsetY {
    return -100.0f;
}

- (WJAlertViewAnimationType) animationType {
    return WJAlertViewAnimationTypeNone;
}

@end
