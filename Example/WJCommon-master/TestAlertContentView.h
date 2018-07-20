//
//  TestAlertContentView.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"
#import "WJAlertView.h"

@interface TestAlertContentView : BaseWJView<IWJAlertContentView>

@property(nonatomic, weak) UIView<IWJAlertView> *containerView;

@end
