//
//  UIColor+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WJ_COLOR_RGBA(r,g,b,a)              ([UIColor wjColorWithRed:r green:g blue:b alpha:a])
#define WJ_COLOR_HEX(hex)                   ([UIColor wjColorWithHex:hex])
#define WJ_COLOR_HEX_STRING(hexString)      ([UIColor wjColorWithHexString:hexString])

@interface UIColor (WJExtension)

+(UIColor*) wjColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+(UIColor*) wjColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

//0x66377A
+(UIColor*) wjColorWithHex:(int) hex;

//支持 @“#123456”、 @“0X123456”、 @“123456” 格式
+(UIColor*) wjColorWithHexString:(NSString*) hexString;

@end
