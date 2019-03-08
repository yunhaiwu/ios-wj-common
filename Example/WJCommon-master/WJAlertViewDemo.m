//
//  WJAlertViewDemo.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJAlertViewDemo.h"
#import "WJAlertView.h"
#import "Masonry.h"
#import "TestAlertContentView.h"

@interface WJAlertViewDemo ()

//@property(nonatomic, weak) WJAlertView *alertView;

@property(nonatomic, weak) TestAlertContentView *contentView;

@end

@implementation WJAlertViewDemo


-(void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"显示/隐藏" forState:UIControlStateNormal];
    [self.wjView addSubview:button];
    [button addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(80, 80)]);
        make.centerX.equalTo(self.wjView.mas_centerX);
        make.centerY.equalTo(self.wjView.mas_centerY);
    }];
    
    self.wjNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"CloseAll" style:UIBarButtonItemStylePlain target:self action:@selector(rightExec:)];
}

-(void) rightExec:(id)sender {
    [WJAlertView closeAllAlertView];
}

-(void) btnExec:(id)sender {
    WJAlertView *alertView = [[WJAlertView alloc] initWithContentView:[TestAlertContentView wjInstance]];
    [alertView showInView:self.view animated:YES];
}


-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
