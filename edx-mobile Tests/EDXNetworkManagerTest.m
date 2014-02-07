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
    id data;
    void (^_before)(kBusinessTag tag);
    void (^_success)(id result,kBusinessTag tag);
    void (^_error)(NSError *error,kBusinessTag tag);
}
@property ResultFlag flag;
@property id data;
@end
@implementation BaseOwner
@synthesize flag;
@synthesize data;
- (id)init {
    self = [super init];
    if (self) {
        flag=Init;
    }
    return self;
}

- (id) initWith:(void(^)(kBusinessTag tag))before
        success:(void(^)(id result,kBusinessTag tag))success
          error:(void(^)(NSError *error,kBusinessTag tag))error{
    _before = before;
    _success = success;
    _error = error;
    return [self init];
};

- (void)before:(kBusinessTag)tag {
    flag=Before;
    if(_before){
        _before(tag);
    }
}

- (void)success:(id)result business:(kBusinessTag)tag {
    flag=Success;
    data=result;
    if(_success){
        _success(result,tag);
    }
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {
    flag=Error;
    if(_error){
        _error(err,tag);
    }
}
@end

SPEC_BEGIN(EDXNetworkManagerTest)
        describe(@"EDXNetworkManager", ^{
            JSObjectionInjector *injector = [JSObjection defaultInjector];
            EDXNetworkManager *manager = [injector getObject:[EDXNetworkManager class]];
            EDXURLHelper *helper = [injector getObject:[EDXURLHelper class]];
            __block NSString *access_token;
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
                BaseOwner *owner = [[BaseOwner alloc] init];
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
                    access_token = [NSString stringWithString:[owner.data objectForKey:@"access_token"]];
                    [[expectFutureValue([owner.data objectForKey:@"scope"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:@"read"];
                    [[expectFutureValue([owner.data objectForKey:@"expires_in"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beNonNil];
                    [[expectFutureValue([owner.data objectForKey:@"refresh_token"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beNonNil];
                });
            });
            context(@"test enroll", ^{
                it(@"should return {'enrollments':[]} before enroll", ^{
                    BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token=access_token;
                    [manager GetEnrollCourseFor:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                    [[expectFutureValue([owner.data objectForKey:@"enrollments"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beEmpty];
                });
                it(@"should be ok to enroll an existing course",^{
                    BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token=access_token;
                    [manager EnrollCourse:@"20220332_1X" owner:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                });
                it(@"should return enrolled course after enroll",^{
                    BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token=access_token;
                    [manager GetEnrollCourseFor:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                    [[expectFutureValue([owner.data objectForKey:@"enrollments"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] haveCountOf:1];
                });
                it(@"should be ok to unenroll an enrolled course",^{
                   BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token = access_token;
                    [manager UnEnrollCourse:@"20220332_1X" owner:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                });
                it(@"should return {'enrollments':[]} after unenroll", ^{
                    BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token=access_token;
                    [manager GetEnrollCourseFor:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                    [[expectFutureValue([owner.data objectForKey:@"enrollments"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] beEmpty];
                });
            });
            context(@"test courseware",^{
                it(@"should return all courses ",^{
                    BaseOwner *owner = [[BaseOwner alloc] init];
                    manager.access_token=access_token;
                    [manager GetCoursesFor:owner];
                    [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                    [[expectFutureValue([owner.data objectForKey:@"courses"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] haveCountOf:3];
                });
                it(@"should return course detail after enroll",^{
                    NSString *course_id = @"30240184_1X";
                    manager.access_token=access_token;
                    BaseOwner *owner;
                    owner = [[BaseOwner alloc] initWith:(void (^)(kBusinessTag)) ^() {
                    }success:^(id result, kBusinessTag tag){
                        if(tag==kBusinessTagEnrollCourse){
                            [manager GetCourseDetail:course_id owner:owner];
                            [[expectFutureValue(theValue(owner.flag)) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] equal:theValue(Success)];
                            [[expectFutureValue([[[[owner.data objectForKey:@"course"] objectForKey:@"children"] objectForKey:@"children"] objectForKey:@"children"]) shouldEventuallyBeforeTimingOutAfter(TIME_OUT)] haveAtLeast:1];
                        }
                    }error:(void (^)(NSError *, kBusinessTag)) ^() {
                    }];
                    [manager EnrollCourse:course_id owner:owner];
                });
            });
        });
        SPEC_END
