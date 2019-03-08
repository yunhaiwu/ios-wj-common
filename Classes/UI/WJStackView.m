//
//  WJStackView.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJStackView.h"

@interface WJStackView ()

@end

@implementation WJStackView

- (NSArray*)arrangedSubviews {
    return [self subviews];
}

- (void)removeArrangedSubview:(UIView*) view {
    if ([[self subviews] containsObject:view]) {
        [view removeFromSuperview];
        [self setNeedsLayout];
    }
}

- (void)addArrangedSubview:(UIView *)view {
    if (![[self subviews] containsObject:view]) {
        [self addSubview:view];
        [self setNeedsLayout];
    }
}

-(void)wjLoadSubViews {
    [super wjLoadSubViews];
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    NSArray *a = [self subviews];
    if (_axis == WJStackViewAxisHorizontal) {
        CGFloat w = self.bounds.size.width / [a count];
        for (int i=0; i<[a count]; i++) {
            UIView *v = a[i];
            [v setFrame:CGRectMake(i*w, 0, w, self.bounds.size.height)];
        }
    } else {
        CGFloat h = self.bounds.size.height / [a count];
        for (int i=0; i<[a count]; i++) {
            UIView *v = a[i];
            [v setFrame:CGRectMake(0, i*h, self.bounds.size.width, h)];
        }
    }
}

-(NSArray *)wjObservableKeypaths {
    return @[@"axis"];
}

-(void)wjChangeForKeypath:(NSString *)keyPath {
    [self setNeedsLayout];
}

@end
