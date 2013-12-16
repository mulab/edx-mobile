//
//  EDXDataManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXDataManager.h"
enum methodTag{
    kGetLoginAccess=0,
    kGetMyCourseList=1,
    kGetAllCourseList=2
};
typedef enum methodTag kMethodTag;
@interface EDXDataManager(Private)
-(id) methodProxy:(kMethodTag)tag owner:(id<EDXUIViewDelegate>) owner;
-(NSString *) _GetLoginAccess:(id<EDXUIViewDelegate>) owner;
-(NSArray *) _GetMyCourseList:(id<EDXUIViewDelegate>)owner;
-(NSArray *) _GetAllCourseList:(id<EDXUIViewDelegate>)owner;
@end
@implementation EDXDataManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EDXDataManager);
@synthesize _owner;
-(id) methodProxy:(kMethodTag)tag owner:(id<EDXUIViewDelegate>)owner{
    if(_owner != nil)[_owner CancelBeforeRefreshFinished];
    _owner = owner;
    [owner BeforeRefreshView];
    switch (tag) {
        case kGetLoginAccess:
            return [self _GetLoginAccess:owner];
            break;
        case kGetAllCourseList:
            return [self _GetAllCourseList:owner];
            break;
        case kGetMyCourseList:
            return [self _GetMyCourseList:owner];
            break;
        default:
            break;
    }
}

-(NSString *) GetUserName{
    NSLog(@"call %s",__func__);
    return @"user@user.com";
}

-(NSString *) GetLoginAccess:(id<EDXUIViewDelegate>) owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetLoginAccess owner:owner];
}

-(NSString *) _GetLoginAccess:(id<EDXUIViewDelegate>) owner{
    return @"0987654321user";
}

-(NSArray *) GetMyCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetMyCourseList owner:owner];
}

-(NSArray *) _GetMyCourseList:(id<EDXUIViewDelegate>)owner{
    return [[[NSArray alloc] init] autorelease];
}

-(NSArray *) GetAllCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetAllCourseList owner:owner];
}

-(NSArray *) _GetAllCourseList:(id<EDXUIViewDelegate>)owner{
    return [[[NSArray alloc] init] autorelease];
}

-(void) dealloc{
    [super dealloc];
}
@end
