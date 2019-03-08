//
//  NSDate+WJExtension.h
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

@interface NSDate (WJExtension)

@property (readonly, nonatomic) NSInteger year;//年
@property (readonly, nonatomic) NSInteger month;//月
@property (readonly, nonatomic) NSInteger day;//天
@property (readonly, nonatomic) NSInteger weekday;//星期
@property (readonly, nonatomic) NSInteger weekOfYear;//一年的第几周
@property (readonly, nonatomic) NSInteger hour;//时
@property (readonly, nonatomic) NSInteger minute;//分
@property (readonly, nonatomic) NSInteger second;//秒

@property (readonly, nonatomic) NSDate *dateByIgnoringTimeComponents;
@property (readonly, nonatomic) NSDate *firstDayOfMonth;
@property (readonly, nonatomic) NSDate *lastDayOfMonth;
@property (readonly, nonatomic) NSDate *firstDayOfWeek;
@property (readonly, nonatomic) NSDate *middleOfWeek;
@property (readonly, nonatomic) NSDate *tomorrow;
@property (readonly, nonatomic) NSDate *yesterday;
@property (readonly, nonatomic) NSInteger numberOfDaysInMonth;

+ (instancetype)dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSInteger)yearsFrom:(NSDate *)date;
- (NSInteger)monthsFrom:(NSDate *)date;
- (NSInteger)weeksFrom:(NSDate *)date;
- (NSInteger)daysFrom:(NSDate *)date;

- (BOOL)isEqualToDateForMonth:(NSDate *)date;
- (BOOL)isEqualToDateForWeek:(NSDate *)date;
- (BOOL)isEqualToDateForDay:(NSDate *)date;

- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)string;

@end



@interface NSCalendar (WJExtension)

+ (instancetype)sharedCalendar;

@end

@interface NSDateFormatter (WJExtension)

+ (instancetype)sharedDateFormatter;

@end

@interface NSDateComponents (WJExtension)

+ (instancetype)sharedDateComponents;

@end
