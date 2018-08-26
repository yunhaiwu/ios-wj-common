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
-(NSKeyValueObservingOptions) wj_observerOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}

- (void) wj_registerForKVO {
    NSArray *keypaths = [self wj_observableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self addObserver:self forKeyPath:keyPath options:[self wj_observerOptionsForKeypath:keyPath] context:NULL];
        }
    }
}

- (void) wj_unregisterFromKVO {
    NSArray *keypaths = [self wj_observableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self removeObserver:self forKeyPath:keyPath];
        }
    }
}

- (NSArray *) wj_observableKeypaths {
	return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self wj_changeForKeypath:keyPath change:change];
}

-(void) wj_changeForKeypath:(NSString*)keyPath change:(NSDictionary *)change {}


-(void)dealloc {
    [self wj_unregisterFromKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) loadBaseWJControlSubviews {
    if (!_wjInitTag) {
        [self wj_registerForKVO];
        _wjInitTag = YES;
    }
    [self wj_loadSubViews];
}

-(void) wj_loadSubViews {}

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

+(instancetype) wj_instance {
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
