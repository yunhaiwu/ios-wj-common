//
//  WJNetworkContext.m
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

#import "WJNetworkContext.h"
#import "WJNetworkContextConfig.h"

@interface WJNetworkContext ()

@property(nonatomic, strong) Reachability *reachability;

@end

@implementation WJNetworkContext

DEF_SINGLETON_INIT(WJNetworkContext)

-(BOOL)isConnection {
    return [self currentStatus] != NotReachable;
}

-(NetworkStatus) currentStatus {
    return [self.reachability currentReachabilityStatus];
}

-(void) addNotification:(id) target selector:(SEL) selector {
    if (target != nil && selector != NULL) {
        [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kReachabilityChangedNotification object:nil];
    }
}
-(void) removeNotification:(id)target {
    if (target) {
        [[NSNotificationCenter defaultCenter] removeObserver:target name:kReachabilityChangedNotification object:nil];
    }
}

-(void)singleInit {
    NSString *host = [[WJNetworkContextConfig sharedInstance] serverHost];
    if (host) {
        self.reachability = [Reachability reachabilityWithHostname:host];
        [self.reachability startNotifier];
    } else {
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];
    }
}


@end
