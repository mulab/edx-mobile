//
//  EDXDataManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXDataManager.h"
#import "EDXCourseModel.h"
NSString *token_key = @"token";
@implementation EDXDataManager{}
objection_register_singleton(EDXDataManager)

-(NSString *) GetUserName{
    NSLog(@"call %s",__func__);
    return @"user@user.com";
}

- (void)saveAccessToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:token_key];
}

-(NSString *)getAccessToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:token_key];
}

-(NSMutableArray *)parseCourseList:(id)courseList{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (id item in courseList){
        EDXCourseModel *model = [[EDXCourseModel alloc] init];
        model.advertisedStart = [item objectForKey:@"advertised_start"];
        model.shortDescription = [item objectForKey:@"short_description"];
        model.displayCourseNum = [item objectForKey:@"display_coursenum"];
        model.courseId = [item objectForKey:@"course_id"];
        model.displayName = [item objectForKey:@"display_name"];
        model.courseImageUrl = [item objectForKey:@"course_image_url"];
        model.marketingVideoUrl = [item objectForKey:@"marketing_video_url"];
        model.displayOrg = [item objectForKey:@"display_org"];
        model.start = [item objectForKey:@"start"];
        [result addObject:model];
    }
    return result;
}

- (void)saveMyCourseList:(id)result {
    NSMutableArray *myCourseList = [self parseCourseList:[result objectForKey:@"enrollments"]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myCourseList];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myCourseList] forKey:@"mycourse"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSMutableArray *)getMyCourseList{
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"mycourse"];
    if(data== nil){
        return [[NSMutableArray alloc] init];
    }
    NSMutableArray *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return result;
}
@end
