//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXUtilities.h"


@implementation EDXUtilities {

}
+ (NSString *)CharToNSString:(char *)cstr {
    return [NSString stringWithCString:cstr encoding:NSUTF8StringEncoding];
}

@end