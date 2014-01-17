//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXGetCourseElementRequest.h"
@interface EDXGetCourseElementRequest(){
    NSString *_type;
}
@end
@implementation EDXGetCourseElementRequest {

}
- (void)setRequestURL {
    [super setRequestURL];
    NSURL *url = [self URL];
    [self setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=%@",[url absoluteString],_type]]];
}

- (id)initWithCourseId:(NSString *)course ElementType:(NSString *)type Token:(NSString *)token {
    self = [super initWithCourseId:course Token:token];
    if(self){
        _type = type;
    }
    return self;
}

@end