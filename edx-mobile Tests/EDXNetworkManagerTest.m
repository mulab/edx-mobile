//
//  EDXNetworkManagerTest.m
//  edx-mobile
//
//  Created by Guang Chen on 2/5/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//
#import "Kiwi.h"
#import "EDXNetworkManager.h"
#import <Objection/Objection.h>
typedef enum{
    Init,
    Before,
    Success,
    Error
}ResultFlag;
static const float TIME_OUT = 1.0;

@interface BaseOwner:NSObject <EDXNetworkDelegate>
{
    ResultFlag flag;
}
@property ResultFlag flag;
@end
@implementation BaseOwner
@synthesize flag;

- (id)init {
    self = [super init];
    if (self) {
        flag=Init;
    }
    return self;
}

- (void)before:(kBusinessTag)tag {
    flag=Before;
}

- (void)success:(id)result business:(kBusinessTag)tag {
    flag=Success;
}

- (void)error:(NSError *)err {
    flag=Error;
}

@end
@interface LoginOwner:BaseOwner
@property id data;
@end
@implementation LoginOwner
@synthesize data;
- (void)success:(id)result business:(kBusinessTag)tag {
    [super success:result business:tag];
    data = result;
}

@end
SPEC_BEGIN(EDXNetworkManagerTest)
        describe(@"EDXNetworkManager", ^{
            JSObjectionInjector *injector = [JSObjection defaultInjector];
            EDXNetworkManager *manager = [injector getObject:[EDXNetworkManager class]];
            EDXURLHelper *helper = [injector getObject:[EDXURLHelper class]];
            context(@"test injection", ^{
                it(@"should have factory", ^{
                    [[[[[manager factory] helper] host] should] equal:@"http://lab.mu:3000%@"];
                });
                it(@"should be able to change host", ^{
                    [[manager factory] helper].host=@"http://localhost:3000%@";
                    [[[[[manager factory] helper] host]should] equal:@"http://localhost:3000%@"];
                    [[[helper host]should] equal:@"http://localhost:3000%@"];
                });
            });
            context(@"test signup", ^{
                BaseOwner *owner = [[BaseOwner alloc] init];
                it(@"should success when signup", ^{
                    EDXSignUpData data = {"user@user.com","username","password","fullname"};
                    [manager SignUpWith:data owner:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                });
                it(@"should failed when missing parameters",^{
                    EDXSignUpData data = {"","","",""};
                    [manager SignUpWith:data owner:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Error)];
                });
            });
            context(@"test login", ^{
                LoginOwner *owner = [[LoginOwner alloc] init];
                it(@"should success when get access",^{
                    EDXLoginData requestData;
                    requestData.username="user@user.com";
                    requestData.password="password";
                    requestData.grant_type="password";
                    requestData.client_id="xxx";
                    requestData.client_secret="xxx";
                    [manager LoginWith:requestData owner:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                    [[expectFutureValue([owner.data objectForKey:@"access_token"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beNonNil];
                    [[expectFutureValue([owner.data objectForKey:@"scope"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:@"read"];
                    [[expectFutureValue([owner.data objectForKey:@"expires_in"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beNonNil];
                    [[expectFutureValue([owner.data objectForKey:@"refresh_token"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beNonNil];
                });
            });
        });
        SPEC_END
