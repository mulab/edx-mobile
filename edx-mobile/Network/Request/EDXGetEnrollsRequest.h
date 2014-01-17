//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkRequest.h"

@interface EDXGetEnrollsRequest : EDXNetworkRequest
- (id) initWithToken:(NSString *)token;
@end