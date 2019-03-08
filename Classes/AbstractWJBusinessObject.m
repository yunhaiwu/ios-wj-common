//
//  BaseBusinessObject.m
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

#import "AbstractWJBusinessObject.h"

@implementation AbstractWJBusinessObject

-(instancetype)init {
    self = [super init];
    if (self) {
        [self wjRegisterForKVO];
    }
    return self;
}

-(void)dealloc {
    [self wjUnregisterFromKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ business description ...",NSStringFromClass(self.class)];
}

#pragma mark KVO
-(NSKeyValueObservingOptions)wjObserverOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}

- (void)wjRegisterForKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self addObserver:self forKeyPath:keyPath options:[self wjObserverOptionsForKeypath:keyPath] context:NULL];
        }
    }
}

- (void)wjUnregisterFromKVO {
    NSArray *keypaths = [self wjObservableKeypaths];
    if (keypaths && keypaths.count > 0) {
        for (NSString *keyPath in keypaths) {
            [self removeObserver:self forKeyPath:keyPath];
        }
    }
}

- (NSArray*)wjObservableKeypaths {
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self wjChangeForKeypath:keyPath change:change];
}

-(void)wjChangeForKeypath:(NSString *)keyPath change:(NSDictionary *)change {}


@end
