//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkRequest.h"
typedef struct {
    char *client_id;
    char *client_secret;
    char *grant_type;
    char const *username;
    char const *password;
}EDXLoginData;
@interface EDXAccessTokenRequest : EDXNetworkRequest
-(id)initWithLoginData:(EDXLoginData)data;
@end