//
//  BaseWJControl.m
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

#import "BaseWJControl.h"

@interface BaseWJControl ()
@property (nonatomic, assign) BOOL wjInitTag;
@end
@implementation BaseWJControl

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

-(void) loadBaseWJControlSubviews {
    if (!_wjInitTag) {
        [self wjRegisterForKVO];
        _wjInitTag = YES;
    }
    [self wjLoadSubViews];
}

-(void)wjLoadSubViews {}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBaseWJControlSubviews];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadBaseWJControlSubviews];
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        [self loadBaseWJControlSubviews];
    }
    return self;
}

+(instancetype)wjInstance {
    BaseWJControl *instance = nil;
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
            instance = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        instance = [[self alloc] init];
    }
    return instance;
}

@end
