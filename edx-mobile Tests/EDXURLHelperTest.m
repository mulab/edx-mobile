//
//  EDXURLHelperTest.m
//  edx-mobile
//
//  Created by Guang Chen on 1/13/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "Kiwi.h"
#import "EDXURLHelper.h"
#import <Objection/Objection.h>
SPEC_BEGIN(EDXURLHelperTest)
describe(@"URLHelper", ^{
    context(@"when used", ^{
        JSObjectionInjector *injector = [JSObjection createInjector];
        EDXURLHelper *helper = [injector getObject:[EDXURLHelper class]];
        it(@"should return sign up url", ^{
            NSURL *result = [helper BuildUrlFor:kBusinessTagSignUp];
            [[result shouldNot] beNil];
            [[result.absoluteString should] containString:@"signup"];
        });
        it(@"should return login url",^{
            NSURL *result = [helper BuildUrlFor:kBusinessTagUserLogin];
            [[result shouldNot] beNil];
            [[result.absoluteString should] containString:@"access_token"];
        });
        it(@"should return get enrollments url", ^{
            NSURL *result = [helper BuildUrlFor:kBusinessTagGetEnrollments];
            [[result shouldNot] beNil];
            [[result.absoluteString should] containString:@"enrollments"];
        });
    });
});
SPEC_END

