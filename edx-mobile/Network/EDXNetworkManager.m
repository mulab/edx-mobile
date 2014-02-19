//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXNetworkManager.h"
#import "AFHTTPRequestOperation.h"
@interface EDXNetworkManager()
- (void)startOperation:(AFHTTPRequestOperation *)operation owner:(id <EDXNetworkDelegate>)owner business:(kBusinessTag)tag;
@end
@implementation EDXNetworkManager {

}
objection_register_singleton(EDXNetworkManager )
objection_requires(@"factory")
@synthesize factory;
@synthesize access_token;
- (void)SignUpWith:(EDXSignUpData)info owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagSignUp];
    NSURLRequest *request = [factory SignUpRequestWithData:info];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/plain", nil];
    [self startOperation:op owner:owner business:(kBusinessTagSignUp)];
}

- (void)LoginWith:(EDXLoginData)data owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagUserLogin];
    NSURLRequest *request = [factory AccessTokenRequestWithData:data];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [self startOperation:op owner:owner business:(kBusinessTagUserLogin)];
}

- (void)GetEnrollCourseFor:(id<EDXNetworkDelegate>)owner{
    [owner before:kBusinessTagGetEnrolls];
    NSURLRequest *request = [factory GetEnrollsRequestWithToken:access_token];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [self startOperation:op owner:owner business:(kBusinessTagGetEnrolls)];
}

- (void)EnrollCourse:(NSString *)courseId owner:(id<EDXNetworkDelegate>)owner{
    [owner before:kBusinessTagEnrollCourse];
    NSURLRequest *request = [factory EnrollCourseRequestWithCourseId:courseId Token:access_token];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", nil];
    [self startOperation:op owner:owner business:(kBusinessTagEnrollCourse)];
}

- (void)UnEnrollCourse:(NSString *)courseId owner:(id<EDXNetworkDelegate>)owner{
    [owner before:kBusinessTagUnEnrollCourse];
    NSURLRequest *request = [factory DeleteEnrollCourseRequestWithCourseId:courseId Token:access_token];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",nil];
    [self startOperation:op owner:owner business:(kBusinessTagUnEnrollCourse)];
}

- (void)GetCoursesFor:(id<EDXNetworkDelegate>)owner{
    [owner before:kBusinessTagGetCourses];
    NSURLRequest *request = [factory GetCoursesWithToken:access_token];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer= [AFJSONResponseSerializer serializer];
    [self startOperation:op owner:owner business:(kBusinessTagGetCourses)];
}

- (void)GetCourseDetail:(NSString *)courseId owner:(id<EDXNetworkDelegate>)owner{
    [owner before:kBusinessTagGetCourseNavigation];
    NSURLRequest *request = [factory GetCourseNavigationWithCourseId:courseId Token:access_token];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [self startOperation:op owner:owner business:(kBusinessTagGetCourseNavigation)];
}

- (void)startOperation:(AFHTTPRequestOperation *)operation owner:(id <EDXNetworkDelegate>)owner business:(kBusinessTag)tag {
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject) {
        [owner success:responseObject business:tag];
    }                                failure:^(AFHTTPRequestOperation *op, NSError *err) {
        [owner error:err business:(tag)];
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}
@end