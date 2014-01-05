//
// Created by Guang Chen on 1/5/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EDXBlock <NSObject>
@required
@property (retain, nonatomic)NSString *location;
@property (retain, nonatomic)NSString *displayName;
@property (retain, nonatomic)NSString *fileLocation;
-(NSString *)serialize;
+(instancetype)initWithJsonString:(NSString *)JsonString;
@end