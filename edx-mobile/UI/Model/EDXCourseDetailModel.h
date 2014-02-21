//
//  EDXCourseDetailModel.h
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDXCourseDetailModel : NSObject<NSCoding>
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *start;
@end
