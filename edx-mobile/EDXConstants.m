//
//  EDXConstants.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXConstants.h"
NSString * const api_key = @"1234567890";
char * const client_id = "xx";
char * const client_secret = "xx";
char * const grant_type = "password";
NSString * const host_string = @"http://localhost:3000%@";
NSString * const out_register_url = @"https://www.xuetangx.com/register";
NSString * const json_header = @"application/json";
NSString * const form_header = @"application/x-www-form-urlencoded";
NSString * const loginUrl = @"http://api.tsinghuax.org/api/v1/auth/login?api_key=%@";
NSString * const loginPost = @"{\"client_id\":11111,\"client_secret\":11111,\"grant_type\":\"password\",\"username\":\"%@\",\"password\":\"%@\"}";
@implementation EDXConstants
//"{\"client_id\":11111,\"client_secret\":11111,\"grant_type\":\"password\",\"username\":\"user@user.com\",\"password\":\"password\"
@end
