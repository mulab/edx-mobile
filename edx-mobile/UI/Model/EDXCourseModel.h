//
//  EDXCourseModel.h
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDXCourseModel : NSObject<NSCoding>
@property(nonatomic, strong) NSString *courseId;
@property(nonatomic, strong) NSString *displayName;
@property(nonatomic, strong) NSString *displayOrg;
@property(nonatomic, strong) NSString *displayCourseNum;
@property(nonatomic, strong) NSString *start;
@property(nonatomic, strong) NSString *advertisedStart;
@property(nonatomic, strong) NSString *shortDescription;
@property(nonatomic, strong) NSString *courseImageUrl;
@property(nonatomic, strong) NSString *marketingVideoUrl;
@end
