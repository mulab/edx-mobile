//
//  EDXChapterModel.m
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXChapterModel.h"
static NSString *const _DISPLAY_NAME = @"display_name";

static NSString *const _CHILDREN = @"children";

static NSString *const _LOCATION = @"location";

static NSString *const _START = @"start";

@implementation EDXChapterModel
@synthesize displayName,children,location,start;

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.displayName forKey:_DISPLAY_NAME];
    [coder encodeObject:self.children forKey:_CHILDREN];
    [coder encodeObject:self.location forKey:_LOCATION];
    [coder encodeObject:self.start forKey:_START];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self){
        self.displayName = [coder decodeObjectForKey:_DISPLAY_NAME];
        self.children = [coder decodeObjectForKey:_CHILDREN];
        self.location = [coder decodeObjectForKey:_LOCATION];
        self.start = [coder decodeObjectForKey:_START];
    }
    return self;
}
@end