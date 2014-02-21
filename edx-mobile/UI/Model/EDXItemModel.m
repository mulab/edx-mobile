//
//  EDXItemModel.m
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXItemModel.h"

static NSString *const _DISPLAY_NAME = @"display_name";

static NSString *const _TYPE = @"type";

static NSString *const _LOCATION = @"location";

@implementation EDXItemModel
@synthesize displayName,type,location;

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.displayName forKey:_DISPLAY_NAME];
    [coder encodeObject:self.type forKey:_TYPE];
    [coder encodeObject:self.location forKey:_LOCATION];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self){
        self.displayName = [coder decodeObjectForKey:_DISPLAY_NAME];
        self.type = [coder decodeObjectForKey:_TYPE];
        self.location = [coder decodeObjectForKey:_LOCATION];
    }
    return self;
}

@end
