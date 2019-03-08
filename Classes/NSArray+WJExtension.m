//
//  NSArray+WJExtension.m
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

#import "NSArray+WJExtension.h"
#import "NSMutableArray+WJExtension.h"
#import "NSString+WJExtension.h"

@implementation NSArray (WJExtension)

- (id)wjFirst {
    return [self firstObject];
}

- (id)wjLast {
    return [self lastObject];
}

- (id)wjSample {
    if (self.count == 0) return nil;
    
    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    return self[index];
}

- (id) wjObjectForKeyedSubscript:(id <NSCopying>)key {
    NSRange range;
    if ([(id)key isKindOfClass:[NSString class]]) {
        NSString *keyString = (NSString *)key;
        range = NSRangeFromString(keyString);
        if ([keyString containsString:@"..."]) {
            range = NSMakeRange(range.location, range.length - range.location);
        } else if ([keyString containsString:@".."]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
    } else if ([(id)key isKindOfClass:[NSValue class]]) {
        range = [((NSValue *)key) rangeValue];
    } else {
        [NSException raise:NSInvalidArgumentException format:@"expected NSString or NSValue argument, got %@ instead", [(id)key class]];
    }
    
    return [self subarrayWithRange:range];
}


- (void)wjEach:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)wjEachWithIndex:(void (^)(id object, NSUInteger  index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (BOOL)wjIncludes:(id)object {
    return [self containsObject:object];
}

- (NSArray *)wjTake:(NSUInteger)numberOfElements {
    numberOfElements = MIN(numberOfElements, [self count]);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [array addObject:self[i]];
    }
    
    return array;
}

- (NSArray *)wjTakeWhile:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id arrayObject in self) {
        if (block(arrayObject))
            [array addObject:arrayObject];
        
        else break;
    }
    
    return array;
}

- (NSArray *)wjMap:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        id newObject = block(object);
        if (newObject) {
            [array addObject:newObject];
        }
    }
    
    return array;
}

- (NSArray *)wjSelect:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (id)wjDetect:(BOOL (^)(id object))block {
    
    for (id object in self) {
        if (block(object))
            return object;
    }
    
    return nil;
}

- (id)wjFind:(BOOL (^)(id object))block {
    return [self wjDetect:block];
}

- (NSArray *)wjReject:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object) == NO) {
            [array addObject:object];
        }
    }
    return array;
}

- (NSArray *)wjFlatten {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in self) {
        if ([object isKindOfClass:NSArray.class]) {
            [array wjConcat:[object wjFlatten]];
        } else {
            [array addObject:object];
        }
    }
    return array;
}

- (NSString *)wjJoin {
    return [self componentsJoinedByString:@""];
}

- (NSString *)wjJoin:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

- (NSArray *)wjSort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)wjSortBy:(NSString*)key; {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)wjReverse {
    return self.reverseObjectEnumerator.allObjects;
}

#pragma mark - Set operations

- (NSArray *)wjIntersectionWithArray:(NSArray *)array {
    NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    return [self filteredArrayUsingPredicate:intersectPredicate];
}

- (NSArray *)wjUnionWithArray:(NSArray *)array {
    NSArray *complement = [self wjRelativeComplement:array];
    return [complement arrayByAddingObjectsFromArray:array];
}

- (NSArray *)wjRelativeComplement:(NSArray *)array {
    NSPredicate *relativeComplementPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:relativeComplementPredicate];
}

- (NSArray *)wjSymmetricDifference:(NSArray *)array {
    NSArray *aSubtractB = [self wjRelativeComplement:array];
    NSArray *bSubtractA = [array wjRelativeComplement:self];
    return [aSubtractB wjUnionWithArray:bSubtractA];
}

@end
