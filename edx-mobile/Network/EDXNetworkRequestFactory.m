//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXNetworkRequestFactory.h"
#import <Objection/Objection.h>
@interface EDXNetworkRequestFactory()
-(NSURLRequest *)ProduceRequest:(EDXNetworkRequest *)request;
@end
@implementation EDXNetworkRequestFactory {

}
objection_register_singleton(EDXNetworkRequestFactory)
objection_requires(@"helper")
@synthesize helper;

- (NSURLRequest *)SignUpRequestWithData: (EDXSignUpData)data{
    return [self ProduceRequest:[[EDXSignUpRequest alloc] initWithSignUpData:data]];
}

- (NSURLRequest *)ProduceRequest:(EDXNetworkRequest *)request {
    [request setRequestURL];
    [request setMethod];
    [request setContentType];
    return request;
}

@end