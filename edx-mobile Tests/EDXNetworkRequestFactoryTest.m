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
        });
SPEC_END

