//
//  BaseWJTableCell.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJTableCell.h"

@interface BaseWJTableCell ()
@property (nonatomic, assign) BOOL wjInitTag;
@end
@implementation BaseWJTableCell

#pragma mark KVO
-(NSKeyValueObservingOptions)wjObserverOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}

- (void) wjRegisterForKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self addObserver:self forKeyPath:keyPath options:[self wjObserverOptionsForKeypath:keyPath] context:NULL];
        }
    }
}

- (void) wjUnregisterFromKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self removeObserver:self forKeyPath:keyPath];
        }
    }
}

- (NSArray *)wjObservableKeypaths {
	return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self wjChangeForKeypath:keyPath change:change];
}

-(void)wjChangeForKeypath:(NSString*)keyPath change:(NSDictionary *)change {}

-(void)dealloc {
    [self wjUnregisterFromKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) loadBaseWJTableCellSubviews {
    if (!_wjInitTag) {
        [self wjRegisterForKVO];
        _wjInitTag = YES;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO;
            break;
        }
    }
    [self wjLoadSubViews];
}

-(void)wjLoadSubViews {
    if (self.contentView) {
        [self.contentView setUserInteractionEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBaseWJTableCellSubviews];
    }
    return self;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBaseWJTableCellSubviews];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadBaseWJTableCellSubviews];
    }
    return self;
}
-(id)init {
    self = [super init];
    if (self) {
        [self loadBaseWJTableCellSubviews];
    }
    return self;
}
-(void)prepareForReuse {
    [super prepareForReuse];
    [self wj_reuseTableCell];
}

-(void) wj_reuseTableCell {
}

+(instancetype)wjInstance {
    BaseWJTableCell *instance = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFile] || [fm fileExistsAtPath:nibFile] || [fm fileExistsAtPath:ipadNibFile]) {
            id o = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
            if ([o isKindOfClass:self]) {
                instance = o;
            }
        }
        if (!instance) {
            instance = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self wj_tableCellIdentifier]];
        }
    }
    @catch (NSException *exception) {
        instance = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self wj_tableCellIdentifier]];
    }
    return instance;
}

+(NSString*) wj_tableCellIdentifier {
    return [[NSString alloc] initWithFormat:@"%@Identifier",NSStringFromClass(self)];
}

+(CGFloat) wj_getDefaultRowHeight:(id)info {
    return 44.0f;
}
@end
