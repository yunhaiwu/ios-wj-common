//
//  NSMutableArray+WJExtension.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/16.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "NSMutableArray+WJExtension.h"
#import "NSArray+WJExtension.h"

@implementation NSMutableArray (WJExtension)

- (void)wjPush:(id)object {
    [self addObject:object];
}

- (id)wjPop {
    id object = [self lastObject];
    [self removeLastObject];
    
    return object;
}

- (NSArray *)wjPop:(NSUInteger)numberOfElements {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++)
        [array insertObject:[self wjPop] atIndex:0];
    
    return array;
}

- (void)wjConcat:(NSArray *)array {
    [self addObjectsFromArray:array];
}

- (id)wjShift {
    NSArray *result = [self wjShift:1];
    return [result wjFirst];
}

- (NSArray *)wjShift:(NSUInteger)numberOfElements {
    NSUInteger shiftLength = MIN(numberOfElements, [self count]);
    NSRange range = NSMakeRange(0, shiftLength);
    NSArray *result = [self subarrayWithRange:range];
    [self removeObjectsInRange:range];
    return result;
}

- (NSArray *)wjKeepIf:(BOOL (^)(id object))block {
    for (NSUInteger i = 0; i < self.count; i++) {
        id object = self[i];
        if (block(object) == NO) {
            [self removeObject:object];
        }
    }
    return self;
}


@end
