//
//  EDXConstants.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXConstants.h"
NSString * const api_key = @"1234567890";
NSString * const loginUrl = @"http://api.tsinghuax.org/api/v1/auth/login?api_key=%@";
NSString * const loginPost = @"{\"client_id\":11111,\"client_secret\":11111,\"grant_type\":\"password\",\"username\":\"%@\",\"password\":\"%@\"}";
@implementation EDXConstants
//"{\"client_id\":11111,\"client_secret\":11111,\"grant_type\":\"password\",\"username\":\"user@user.com\",\"password\":\"password\"
@end
