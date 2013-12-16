//
//  EDXDataManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXDataManager.h"
@implementation EDXDataManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EDXDataManager);

-(NSString *) GetUserName{
    NSLog(@"call %s",__func__);
    return @"user@user.com";
}

-(NSString *) GetLoginAccess{
    NSLog(@"call %s",__func__);
    return @"0987654321user";
}

-(NSArray *) GetMyCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [[[NSArray alloc] init] autorelease];
}

-(NSArray *) GetAllCourseList:(id<EDXUIViewDelegate>)owner{
    NSLog(@"call %s",__func__);
    return [[[NSArray alloc] init] autorelease];
}
@end
