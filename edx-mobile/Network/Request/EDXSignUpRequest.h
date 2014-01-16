//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkRequest.h"
#import "EDXURLHelper.h"
typedef struct {
    __strong NSString *email;
    __strong NSString *username;
    __strong NSString *password;
    __strong NSString *full_name;
} EDXSignUpData;
@interface EDXSignUpRequest : EDXNetworkRequest
-(id)initWithSignUpData:(EDXSignUpData)data;
@property (strong, nonatomic)EDXURLHelper *helper;
@end