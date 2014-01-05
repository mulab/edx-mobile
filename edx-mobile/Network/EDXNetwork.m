//
//  EDXNetwork.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXNetwork.h"
#import "EDXConstants.h"
#import "EDXURIHelper.h"
#import "EDXGetCourseContent.h"
@implementation EDXNetwork
SYNTHESIZE_SINGLETON_FOR_CLASS(EDXNetwork);

- (id)init
{
    self = [super init];
    if (self) {
        queue=[[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)getBusinessReq:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req==nil) {
        req=[[EDXNetworkRequest alloc]init];
    }
    req.businessTag=tag;
    req.requestStatus=kRequestStatusNone;
    [queue setObject:req forKey:[NSNumber numberWithInt:tag]];
    req.enc=NSUTF8StringEncoding;
    req.owner=owner;
    if (tag==kBusinessTagGetEnrollments) {
        req.url=[EDXURIHelper GetEnrollUrl];
    }else if (tag==kBusinessTagGetCourseVideoList){
        req.url=[EDXURIHelper GetVideoListWithCourseId:[(id<EDXGetCourseContent>)owner GetCouseId]];
    } else {
        req.url=@"string";
    }
    NSLog(@"%s:%@",__FUNCTION__,req.url);
    [req getWithDelegate:self];
    if(owner!=nil)[owner beginPost:tag];
}
-(void)postBusinessReq:(NSString*)json
                   tag:(kBusinessTag)tag
                 owner:(id<EDXNetworkDelegate>)owner{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req==nil) {
        req=[[EDXNetworkRequest alloc]init];
    }
    req.businessTag=tag;
    req.requestStatus=kRequestStatusNone;
    
    [queue setObject:req forKey:[NSNumber numberWithInt:tag]];
    req.enc=NSUTF8StringEncoding;
    req.owner=owner;
    
    if (tag==kBusinessTagUserLogin) {
        req.url=[EDXURIHelper GetLoginUrl];
    }
    else{
        req.url=@"";
    }
    NSLog(@"%s:%@",__FUNCTION__,req.url);
    [req postJson:json delegate:self];
    if(owner!=nil) [owner beginPost:tag];
}
-(void)cancel:(kBusinessTag)tag{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req && [req isKindOfClass:[EDXNetworkRequest class]]) {
        [req cancel];
    }
}
#pragma mark ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:
                                    [NSNumber numberWithInt:request.tag]];
    req.requestStatus=kRequestStatusEnded;
    if (req.owner!=nil) {
        [req.owner endPost:req.result
				  business: req.businessTag];
    }
    
}
- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"request start");
    NSLog(@"%@",[request description]);
}
// 请求失败，获取 error
- (void)requestFailed:(ASIHTTPRequest *)request
{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:
                                    [NSNumber numberWithInt:request.tag]];
	NSError *error = [request error];
	if (req.owner!=nil) {
        [req.owner errorPost:error];
    }
}
-(void)dealloc{
    [queue release];
    [super dealloc];
}
@end