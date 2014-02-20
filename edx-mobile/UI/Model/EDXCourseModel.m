//
//  EDXCourseModel.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXCourseModel.h"
static NSString *const _COURSE_ID = @"courseId";

static NSString *const _DISPLAY_NAME = @"displayName";

static NSString *const _DISPLAY_ORG = @"displayOrg";

static NSString *const _DISPLAY_COURSE_NUM = @"displayCourseNum";

static NSString *const _START = @"start";

static NSString *const _ADVERTISED_START = @"advertisedStart";

static NSString *const _SHORT_DESCRIPTION = @"shortDescription";

static NSString *const _COURSE_IMAGE_URL = @"courseImageUrl";

static NSString *const _MARKETING_VIDEO_URL = @"marketingVideoUrl";

@implementation EDXCourseModel
@synthesize courseId,displayName,displayOrg,displayCourseNum,start,advertisedStart,shortDescription,courseImageUrl,marketingVideoUrl;
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.courseId forKey:_COURSE_ID];
    [coder encodeObject:self.displayName forKey:_DISPLAY_NAME];
    [coder encodeObject:self.displayOrg forKey:_DISPLAY_ORG];
    [coder encodeObject:self.displayCourseNum forKey:_DISPLAY_COURSE_NUM];
    [coder encodeObject:self.start forKey:_START];
    [coder encodeObject:self.advertisedStart forKey:_ADVERTISED_START];
    [coder encodeObject:self.shortDescription forKey:_SHORT_DESCRIPTION];
    [coder encodeObject:self.courseImageUrl forKey:_COURSE_IMAGE_URL];
    [coder encodeObject:self.marketingVideoUrl forKey:_MARKETING_VIDEO_URL];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self){
        self.courseId = [coder decodeObjectForKey:_COURSE_ID];
        self.displayName = [coder decodeObjectForKey:_DISPLAY_NAME];
        self.displayOrg = [coder decodeObjectForKey:_DISPLAY_ORG];
        self.displayCourseNum = [coder decodeObjectForKey:_DISPLAY_COURSE_NUM];
        self.start = [coder decodeObjectForKey:_START];
        self.advertisedStart = [coder decodeObjectForKey:_ADVERTISED_START];
        self.shortDescription = [coder decodeObjectForKey:_SHORT_DESCRIPTION];
        self.courseImageUrl = [coder decodeObjectForKey:_COURSE_IMAGE_URL];
        self.marketingVideoUrl = [coder decodeObjectForKey:_MARKETING_VIDEO_URL];
    }
    return self;
}

@end
