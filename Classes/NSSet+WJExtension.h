//
//  NSSet+WJExtension.h
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
 *  集合扩展
 */
@interface NSSet (WJExtension)

/**
 *  第一个元素
 */
@property(readonly) id wjFirst;

/**
 *  最后一个元素
 */
@property(readonly) id wjLast;

/**
 * 随机一个元素
 */
@property(readonly) id wjSample;

/**
 *  遍历集合元素
 *
 *  @param block 遍历block
 */
- (void)wjEach:(void (^)(id object))block;

/**
 *  遍历集合元素
 *
 *  @param block 遍历block
 */
- (void)wjEachWithIndex:(void (^)(id object, NSUInteger index))block;

/**
 *  筛选集合元素
 *
 *  @param block 筛选block
 *
 *  @return 筛选结果
 */
- (NSArray*)wjSelect:(BOOL (^)(id object))block;

/**
 *  与qw_select 相反
 */
- (NSArray*)wjReject:(BOOL (^)(id object))block;

/**
 *  将集合元素转成想要对象
 */
- (NSArray*)wjMap:(id (^)(id object))block;

/**
 *  排序集合
 *
 *  @return 排序结果
 */
- (NSArray*)wjSort;


@end
