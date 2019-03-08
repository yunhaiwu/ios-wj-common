//
//  NSNotificationCenter+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/4.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

//POST
#define WJ_NOTIFY_POST(N)                                   [NSNotificationCenterpostNotificationOnMainThread:N]
#define WJ_NOTIFY_POST_WAIT(N,W)                            [NSNotificationCenterpostNotificationOnMainThread:N waitUntilDone:W]
#define WJ_NOTIFY_POST_NAME_OBJECT(N,O)                     [NSNotificationCenterpostNotificationOnMainThreadWithName:N object:O]
#define WJ_NOTIFY_POST_NAME_OBJECT_USERINFO(N,O,U)          [NSNotificationCenterpostNotificationOnMainThreadWithName:N object:O userInfo:U]
#define WJ_NOTIFY_POST_NAME_OBJECT_USERINFO_WAIT(N,O,U,W)   [NSNotificationCenterpostNotificationOnMainThreadWithName:N object:O userInfo:U waitUntilDone:W]

//REMOVE
#define WJ_NOTIFY_REMOVE(OBS)                               [[NSNotificationCenter defaultCenter] removeObserver:OBS]
#define WJ_NOTIFY_REMOVE_NAME_OBJECT(OBS,N,O)               [[NSNotificationCenter defaultCenter] removeObserver:OBS name:N object:O]

//ADD
#define WJ_NOTIFY_ADD_OBSERVER(OBS,S,N,O)                   [[NSNotificationCenter defaultCenter] addObserver:OBS selector:S name:N object:O]


@interface NSNotificationCenter (WJExtension)

+ (void)postNotificationOnMainThread:(NSNotification *)notification;

+ (void)postNotificationOnMainThread:(NSNotification *)notification
                         waitUntilDone:(BOOL)wait;

+ (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object;

+ (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo;

+ (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;



@end
