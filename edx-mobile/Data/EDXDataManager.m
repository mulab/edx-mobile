//
//  EDXDataManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXDataManager.h"
#import "EDXNetworkManager.h"
#import "EDXConstants.h"

enum methodTag{
    kGetLoginAccess=0,
    kGetMyCourseList=1,
    kGetAllCourseList=2
};
typedef enum methodTag kMethodTag;
@interface EDXDataManager(Private)
-(id) methodProxy:(kMethodTag)tag owner:(id<EDXUIViewDelegate>) owner;
-(NSString *) _GetLoginAccess;
-(NSArray *) _GetMyCourseList;
-(NSArray *) _GetAllCourseList;
@property (nonatomic,retain) NSArray * _MyCourseList;
@end
@implementation EDXDataManager
//objection_register_singleton(EDXDataManager )
@synthesize _owner;

-(id)init{
    if (!(self = [super init])) return nil;
    self._MyCourseList = [[NSArray alloc] init];
    return self;
}

-(id) methodProxy:(kMethodTag)tag owner:(id<EDXUIViewDelegate>)owner{
    if(_owner != nil)[_owner CancelBeforeRefreshFinished];
    _owner = owner;
    [owner BeforeRefreshView];
    switch (tag) {
        case kGetLoginAccess:
            return [self _GetLoginAccess];
        case kGetAllCourseList:
            return [self _GetAllCourseList];
        case kGetMyCourseList:
            return [self _GetMyCourseList];
    }
    return nil;
}

-(NSString *) GetUserName{
    NSLog(@"call %s",__func__);
    return @"user@user.com";
}

-(NSString *) GetLoginAccess:(id<EDXUIViewDelegate>) owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetLoginAccess owner:owner];
}

-(NSString *) _GetLoginAccess{
    return @"0987654321user";
}

-(NSArray *) GetMyCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetMyCourseList owner:owner];
}

-(NSArray *) _GetMyCourseList{
    //TODO : send msg to NetworkManager
    return self._MyCourseList;
}

-(NSArray *) GetAllCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [self methodProxy:kGetAllCourseList owner:owner];
}

-(NSArray *) _GetAllCourseList{
    return [[NSArray alloc] init];
}

-(void) dealloc{
    self._MyCourseList;
}

#pragma mark EDXNetwork delegate
- (void)before:(kBusinessTag)tag {
}

- (void)success:(NSData *)result business:(kBusinessTag)tag {
    //TODO : write to database
    //TODO : write to cache
    [_owner RefreshView];
}

- (void)error:(NSError *)err {
    [_owner ErrorOnRefreshView:err];
}

@end
