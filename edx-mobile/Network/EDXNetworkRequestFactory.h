//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXConstants.h"
#import "EDXURLHelper.h"
#import "EDXSignUpRequest.h"
#import "EDXAccessTokenRequest.h"
#import "EDXEnrollCourseRequest.h"
#import "EDXDeleteEnrollCourseRequest.h"

@interface EDXNetworkRequestFactory : NSObject
- (NSURLRequest *)SignUpRequestWithData: (EDXSignUpData)data;
- (NSURLRequest *)AccessTokenRequestWithData: (EDXLoginData)data;
- (NSURLRequest *)EnrollCourseRequestWithCourseId: (NSString *)course Token:(NSString *)token;
- (NSURLRequest *)DeleteEnrollCourseRequestWithCourseId: (NSString *)course Token:(NSString *)token;
@property (nonatomic, strong)EDXURLHelper *helper;
@end