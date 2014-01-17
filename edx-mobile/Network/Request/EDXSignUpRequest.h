//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkRequest.h"
#import "EDXURLHelper.h"
typedef struct {
    char *email;
    char *username;
    char *password;
    char *full_name;
} EDXSignUpData;
@interface EDXSignUpRequest : EDXNetworkRequest
-(id)initWithSignUpData:(EDXSignUpData)data;
@end