//
//  EDXNetworkRequestFactoryTest.m
//  edx-mobile
//
//  Created by Guang Chen on 1/17/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "Kiwi.h"
#import "EDXNetworkRequestFactory.h"
#import <Objection/Objection.h>

SPEC_BEGIN(EDXNetworkRequestFactoryTest)
        describe(@"EDXNetworkRequestFactory", ^{
            JSObjectionInjector *injector = [JSObjection createInjector];
            EDXNetworkRequestFactory *factory = [injector getObject:[EDXNetworkRequestFactory class]];
            context(@"when used for producing sign request", ^{
                EDXSignUpData data = {"user@user.com","username","password","user_full"};
                NSURLRequest *request = [factory SignUpRequestWithData:data];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString] should] containString:@"signup"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod] should] equal:@"POST"];
                });
                it(@"should have header with api key", ^{
                    [[[request valueForHTTPHeaderField:@"X-edx-api-key"]should] equal:api_key];
                });
                it(@"should have correct content type", ^{
                    [[[request valueForHTTPHeaderField:@"content-type"] should] equal:json_header];
                });
            });

            context(@"when used for producing enroll course request", ^{
                NSURLRequest *request = [factory EnrollCourseRequestWithCourseId:@"hello" Token:@"1234567890"];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString]should] containString:@"/edx-api/enrollments/v1/hello"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod]should] equal:@"POST"];
                });
                it(@"should have header with token",^{
                    [[[request valueForHTTPHeaderField:@"Authorization"]should] equal:@"Bearer 1234567890"];
                });
            });

            context(@"when used for producing delete enrolled course request", ^{
                NSURLRequest *request = [factory DeleteEnrollCourseRequestWithCourseId:@"hello" Token:@"1234567890"];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString]should] containString:@"/edx-api/enrollments/v1/hello"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod]should] equal:@"DELETE"];
                });
                it(@"should have header with token",^{
                    [[[request valueForHTTPHeaderField:@"Authorization"]should] equal:@"Bearer 1234567890"];
                });
            });

            context(@"when used for producing get enrolled course list request", ^{
                NSURLRequest *request = [factory GetEnrollsRequestWithToken:@"1234567890"];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString]should] containString:@"/edx-api/enrollments/v1/"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod]should] equal:@"GET"];
                });
                it(@"should have header with token",^{
                    [[[request valueForHTTPHeaderField:@"Authorization"]should] equal:@"Bearer 1234567890"];
                });
            });

            context(@"when used for producint get course navigation request", ^{
                NSURLRequest *request = [factory GetCourseNavigationWithCourseId:@"hello" Token:@"1234567890"];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString]should] containString:@"/edx-api/courseware/v1/hello"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod]should] equal:@"GET"];
                });
                it(@"should have header with token",^{
                    [[[request valueForHTTPHeaderField:@"Authorization"]should] equal:@"Bearer 1234567890"];
                });
            });

            context(@"when used for producint get course element request", ^{
                NSURLRequest *request = [factory GetCourseElementRequestWithCourseId:@"hello" ElementType:@"vedio" Token:@"1234567890"];
                it(@"should have correct url", ^{
                    [[[[request URL] absoluteString]should] containString:@"/edx-api/courseware/v1/hello?type=vedio"];
                });
                it(@"should have correct method", ^{
                    [[[request HTTPMethod]should] equal:@"GET"];
                });
                it(@"should have header with token",^{
                    [[[request valueForHTTPHeaderField:@"Authorization"]should] equal:@"Bearer 1234567890"];
                });
            });
        });
SPEC_END

