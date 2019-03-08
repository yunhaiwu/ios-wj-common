//
//  NSString+WJExtension.m
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

#import "NSString+WJExtension.h"
#import "NSArray+WJExtension.h"

static NSString *const UNDERSCORE = @"_";
static NSString *const SPACE = @" ";
static NSString *const EMPTY_STRING = @"";

NSString *NSStringWithFormat(NSString *formatString, ...) {
    va_list args;
    va_start(args, formatString);
    
    NSString *string = [[NSString alloc] initWithFormat:formatString arguments:args];
    
    va_end(args);
    
#if defined(__has_feature) && __has_feature(objc_arc)
    return string;
#else
    return [string autorelease];
#endif
}


@implementation NSString (WJExtension)

- (NSArray*)wjSplit {
    NSArray *result = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [result wjSelect:^BOOL(NSString *string) {
        return string.length > 0;
    }];
}

- (NSArray*)wjSplit:(NSString *)delimiter {
    return [self componentsSeparatedByString:delimiter];
}

- (NSString*)wjCamelCase {
    NSString *spaced = [self stringByReplacingOccurrencesOfString:UNDERSCORE withString:SPACE];
    NSString *capitalized = [spaced capitalizedString];
    
    return [capitalized stringByReplacingOccurrencesOfString:SPACE withString:EMPTY_STRING];
}

- (BOOL)wjContainsString:(NSString *) string {
    NSRange range = [self rangeOfString:string options:NSCaseInsensitiveSearch];
    return range.location != NSNotFound;
}

- (NSString*)wjStrip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
