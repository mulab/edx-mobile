//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXNetworkRequestFactory.h"
#import <Objection/Objection.h>

@implementation EDXNetworkRequestFactory {

}
objection_register_singleton(EDXNetworkRequestFactory )
objection_requires(@"helper")
@synthesize helper;

- (NSMutableURLRequest *)SignUpRequestWithData: (EDXSignUpData)data{
    return [[EDXSignUpRequest alloc] initWithSignUpData:data];
}

@end