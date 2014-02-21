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
#import "EDXCourseDetailModel.h"
#import "EDXChapterModel.h"
#import "EDXSubChapterModel.h"
#import "EDXItemModel.h"
#import "EDXVideoItemModel.h"

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

-(EDXCourseDetailModel *)parseCourseDetail:(id)courseDetail{
    EDXCourseDetailModel *result = [[EDXCourseDetailModel alloc] init];
    result.displayName = [courseDetail objectForKey:@"display_name"];
    result.location = [courseDetail objectForKey:@"location"];
    result.start = [courseDetail objectForKey:@"start"];
    result.courseId = [courseDetail objectForKey:@"course_id"];
    NSMutableArray *chapters_result = [[NSMutableArray alloc] init];
    NSMutableArray *chapters = [courseDetail objectForKey:@"children"];
    for(id chapter in chapters){
        EDXChapterModel *chapter_result = [[EDXChapterModel alloc] init];
        chapter_result.displayName = [chapter objectForKey:@"display_name"];
        chapter_result.location = [chapter objectForKey:@"location"];
        chapter_result.start = [chapter objectForKey:@"start"];
        NSMutableArray *subChapters = [chapter objectForKey:@"children"];
        NSMutableArray *subChapters_result = [[NSMutableArray alloc] init];
        for(id sub in subChapters){
            EDXSubChapterModel *subChapter_result = [[EDXSubChapterModel alloc] init];
            subChapter_result.displayName = [sub objectForKey:@"display_name"];
            subChapter_result.location = [sub objectForKey:@"location"];
            subChapter_result.start = [sub objectForKey:@"start"];
            NSMutableArray *items = [sub objectForKey:@"children"];
            NSMutableArray *items_result = [[NSMutableArray alloc] init];
            for(id item in items){
                NSString *type = [item objectForKey:@"type"];
                if([type isEqualToString:@"text"]){
                    EDXItemModel *item_result = [[EDXItemModel alloc] init];
                    item_result.type = type;
                    item_result.location = [item objectForKey:@"location"];
                    item_result.displayName = [item objectForKey:@"display_name"];
                    [items_result addObject:item_result];
                }else if([type isEqualToString:@"video"]){
                    EDXVideoItemModel *item_result = [[EDXVideoItemModel alloc] init];
                    item_result.type = type;
                    item_result.location = [item objectForKey:@"location"];
                    item_result.displayName = [item objectForKey:@"display_name"];
                    item_result.url = [item objectForKey:@"alt"];
                    item_result.transcript = [item objectForKey:@"transcript_url"];
                    [items_result addObject:item_result];
                }
            }
            subChapter_result.children = items_result;
            [subChapters_result addObject:subChapter_result];
        }
        chapter_result.children = subChapters_result;
        [chapters_result addObject:chapter_result];
    }
    result.children = chapters_result;
    return result;
}

-(void)saveCourseDetail:(id)result{
    EDXCourseDetailModel *courseDetail = [self parseCourseDetail:[result objectForKey:@"course"]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:courseDetail];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:courseDetail.courseId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveMyCourseList:(id)result {
    NSMutableArray *myCourseList = [self parseCourseList:[result objectForKey:@"enrollments"]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myCourseList];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"mycourse"];
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

-(EDXCourseDetailModel *)getCourseDetail:(NSString *)courseId{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:courseId];
    if(data == nil){
        return [[EDXCourseDetailModel alloc] init];
    }
    EDXCourseDetailModel *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return result;
}
@end
