//
//  NSArray+WJExtension.h
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

@interface NSArray (WJExtension)

/**
 *  第一个元素
 */
- (id)wjFirst;

/**
 *  最后一个元素
 */
- (id)wjLast;


/**
 *  随机一个元素
 */
- (id)wjSample;


/**
 * 根据下标返回元素列表
 */
- (id)wjObjectForKeyedSubscript:(id <NSCopying>)key;


/**
 * 遍历所有元素
 */
- (void)wjEach:(void (^)(id object))block;

/**
 * 遍历所有元素
 */
- (void)wjEachWithIndex:(void (^)(id object, NSUInteger index))block;

/**
 *  是否包含此元素
 */
- (BOOL)wjIncludes:(id)object;

/**
 *  返回指定数量的元素
 */
- (NSArray*)wjTake:(NSUInteger)numberOfElements;

/**
 *  根据条件返回元素
 */
- (NSArray *)wjTakeWhile:(BOOL (^)(id object))block;

/**
 *  遍历整个数组
 */
- (NSArray *)wjMap:(id (^)(id object))block;

/**
 *  根据条件返回数据
 */
- (NSArray *)wjSelect:(BOOL (^)(id object))block;

/**
 *  查找元素
 */
- (id)wjDetect:(BOOL (^)(id object))block;


/**
 *  查找元素
 */
- (id)wjFind:(BOOL (^)(id object))block;

/**
 *  不符合条件数组
 */
- (NSArray *)wjReject:(BOOL (^)(id object))block;

/**
 *  将数组中所有是数组的元素全部作为一个数组返回
 */
- (NSArray *)wjFlatten;

/**
 *  将数组连接成字符串
 */
- (NSString *)wjJoin;

/**
 *  根据指定字符连接数组
 */
- (NSString *)wjJoin:(NSString *)separator;

/**
 *  排序（compare:）
 */
- (NSArray *)wjSort;

/**
 *  根据指定字段排序
 */
- (NSArray *)wjSortBy:(NSString*)key;

/**
 *  翻转字符串
 */
- (NSArray *)wjReverse;

/**
 *  查找在array中的数组元素
 *
 *  @param array 条件数组
 *
 *  @return 在array数据中的数据集合
 */
- (NSArray *)wjIntersectionWithArray:(NSArray *)array;

/**
 *  合并两个数组
 */
- (NSArray *)wjUnionWithArray:(NSArray *)array;

/**
 *  筛选不在array中的数据元素
 *
 *  @param array 条件数组
 *
 *  @return 不在array中的数据集合
 */
- (NSArray *)wjRelativeComplement:(NSArray *)array;

/**
 *  补集，不同时在当前数组和array中的元素集合
 *
 *  @param array 条件数组
 *
 *  @return 补集结果
 */
- (NSArray *)wjSymmetricDifference:(NSArray *)array;

@end
