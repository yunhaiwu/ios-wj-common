//
//  WJActiveSheetDemo.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/15.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJActiveSheetDemo.h"
#import "WJActionSheetView.h"
#import "TextActionSheetContentView.h"
#import "Masonry.h"

@interface WJActiveSheetDemo ()

@property (nonatomic, weak) UIView<IWJActionSheetView> *containerView;

@property (nonatomic, weak) TextActionSheetContentView *contentView;

@end

@implementation WJActiveSheetDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_containerView) {
        WJActionSheetView *v = [[WJActionSheetView alloc] initWithContentView:[TextActionSheetContentView wj_instance]];
        [self.view addSubview:v];
        _containerView = v;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"显示/隐藏" forState:UIControlStateNormal];
        [self.wjView addSubview:button];
        [button addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(80, 80)]);
            make.centerX.equalTo(self.wjView.mas_centerX);
            make.centerY.equalTo(self.wjView.mas_centerY);
        }];
    }
}

-(void) btnExec:(id)sender {
    NSLog(@"dddddd");
    if ([_containerView isHide]) {
        [_containerView show:YES];
    } else {
        [_containerView hide:YES];
    }
}


-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
