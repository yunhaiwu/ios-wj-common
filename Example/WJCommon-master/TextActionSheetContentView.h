//
//  TextActionSheetContentView.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/15.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"
#import "WJActionSheetView.h"

@interface TextActionSheetContentView : BaseWJView<IWJActionSheetContentView>

@property(nonatomic, weak) UIView<IWJActionSheetView> *containerView;

@end
