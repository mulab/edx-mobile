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

- (NSURLRequest *)AccessTokenRequestWithData:(EDXLoginData)data {
    return [self ProduceRequest:[[EDXAccessTokenRequest alloc] initWithLoginData:data]];
}

- (NSURLRequest *)EnrollCourseRequestWithCourseId:(NSString *)course Token:(NSString *)token {
    return [self ProduceRequest:[[EDXEnrollCourseRequest alloc] initWithCourseId:course Token:token]];
}

- (NSURLRequest *)DeleteEnrollCourseRequestWithCourseId:(NSString *)course Token:(NSString *)token {
    return [self ProduceRequest:[[EDXDeleteEnrollCourseRequest alloc] initWithCourseId:course Token:token]];
}

- (NSURLRequest *)GetEnrollsRequestWithToken:(NSString *)token {
    return [self ProduceRequest:[[EDXGetEnrollsRequest alloc] initWithToken:token]];
}

- (NSURLRequest *)GetCourseNavigationWithCourseId:(NSString *)course Token:(NSString *)token {
    return [self ProduceRequest:[[EDXGetCourseNavigationRequest alloc] initWithCourseId:course Token:token]];
}


- (NSURLRequest *)ProduceRequest:(EDXNetworkRequest *)request {
    [request setRequestURL];
    [request setMethod];
    [request setContentType];
    return request;
}

@end