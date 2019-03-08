//
//  TextActionSheetContentView.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/15.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "TextActionSheetContentView.h"
#import "Masonry.h"

@interface TextActionSheetContentView ()

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, assign) CGFloat h;

@end

@implementation TextActionSheetContentView

-(void)wjloadSubViews {
    [super wjLoadSubViews];
    [self setBackgroundColor:[UIColor whiteColor]];
    if (!_button) {
        self.h = 300;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"Close" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _button = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(60, 40)]);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn2 setBackgroundColor:[UIColor redColor]];
        [btn2 setTitle:@"layout" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn2Exec:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(60, 40)]);
            make.top.equalTo(_button.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
}

-(void) btnExec:(id)sender {
    [self.containerView hide:YES];
}

-(void) btn2Exec:(id)sender {
    if (self.h == 400.0f) {
        self.h = 300.0f;
    } else {
        self.h = 400.0f;
    }
    [self.containerView relayoutContentView];
    
}

#pragma mark IWJActionSheetContentView
- (CGFloat)contentViewHeight {
    if (self.h == 0) {
        return 300.0f;
    }
    return self.h;
}

- (CGFloat)backgroundAlpha {
    return 0.3f;
}

-(BOOL)touchBackgroundDismiss {
    return YES;
}

@end
