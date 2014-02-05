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
@interface BaseOwner:NSObject <EDXNetworkDelegate>
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

- (void)success:(NSData *)result business:(kBusinessTag)tag {
    flag=Success;
}

- (void)error:(NSError *)err {
    flag=Error;
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
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(1.0)] equal:theValue(Success)];
                });
            });
        });
        SPEC_END
