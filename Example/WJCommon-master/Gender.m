//
//  Gender.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//  Created by Yunhai.Wu on 15/11/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "Gender.h"

@interface Gender ()

@end

static NSSet *genders;

@implementation Gender

+(void)load {
    genders = [[NSSet alloc] initWithObjects:
               ENUMINIT(0, @"男"),
               ENUMINIT(1, @"女"),
               nil];
}

+(NSSet *)values {
    return genders;
}

+(instancetype)man {
    return (Gender*)[self getEnumByValue:0];
}

+(instancetype)women {
    return (Gender*)[self getEnumByValue:1];
}

@end
