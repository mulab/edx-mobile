//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXConstants.h"
#import "EDXURLHelper.h"

@interface EDXNetworkRequestFactory : NSObject
-(NSMutableURLRequest *)SignUpRequest;
-(NSURLRequest *)RequestFor:(kBusinessTag)tag;
@property (nonatomic, strong)EDXURLHelper *helper;
@end