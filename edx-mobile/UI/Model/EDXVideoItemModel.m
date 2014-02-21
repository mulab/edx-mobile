//
//  EDXVideoItemModel.m
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXVideoItemModel.h"

static NSString *const _VIDEO_URL = @"alt";

static NSString *const _TRANSCRIPT = @"transcript_url";

@implementation EDXVideoItemModel
@synthesize url,transcript;

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.url forKey:_VIDEO_URL];
    [coder encodeObject:self.transcript forKey:_TRANSCRIPT];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.url = [coder decodeObjectForKey:_VIDEO_URL];
        self.transcript = [coder decodeObjectForKey:_TRANSCRIPT];
    }
    return self;
}

@end
