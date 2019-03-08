//
//  NSDictionary+WJExtension.h
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

#import <Foundation/Foundation.h>

/**
 *  词典扩展
 */
@interface NSDictionary (WJExtension)
/**
 *  遍历词典
 *
 *  @param block 遍历block
 */
- (void)wjEach:(void (^)(id key, id value))block;

/**
 *  遍历词典所有key
 *
 *  @param block 遍历block
 */
- (void)wjEachKey:(void (^)(id key))block;

/**
 *  遍历词典所有值
 *
 *  @param block 遍历block
 */
- (void)wjEachValue:(void (^)(id value))block;

/**
 *  转换词典
 */
- (NSArray *)wjMap:(id (^)(id key, id value))block;

/**
 *  是否存在key
 *
 *  @param key key
 *
 *  @return 是否存在
 */
- (BOOL)wjHasKey:(id)key;

@end
