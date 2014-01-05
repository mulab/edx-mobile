//
//  EDXNetworkManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXNetworkManager.h"
#import "EDXURIHelper.h"
#import "EDXGetCourseContent.h"

@implementation EDXNetworkManager
@synthesize enc;
SYNTHESIZE_SINGLETON_FOR_CLASS(EDXNetworkManager);
- (id) init
{
    self = [super init];
    if (self){
        queue=[[NSMutableDictionary alloc]init];
        enc=NSUTF8StringEncoding;
    }
    return self;
}

- (void)getBusinessReq:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner{
    NSLog(@"%s",__func__);
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req==nil) {
        req= [[[EDXNetworkRequest alloc] init] autorelease];
    }
    req.businessTag=tag;
    req.requestStatus=kRequestStatusNone;
    [queue setObject:req forKey:[NSNumber numberWithInt:tag]];
    req.enc=enc;
    req.owner=owner;
    if([[owner.class client] respondsToSelector:@selector(GetCouseId)]){
        req.url=[EDXURIHelper GetUrlForBusiness:tag Course:[(id<EDXGetCourseContent>)owner GetCouseId]];
    }else{
        req.url=[EDXURIHelper GetUrlForBusiness:tag];
    }
    NSLog(@"%s:%@",__FUNCTION__,req.url);
    [req getWithDelegate:self];
    if(owner!= nil)[owner beginRequest:tag];
}

- (void)postBusinessReq:(NSString *)json tag:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner{
    NSLog(@"%s",__func__);
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req==nil) {
        req= [[[EDXNetworkRequest alloc] init] autorelease];
    }
    req.businessTag=tag;
    req.requestStatus=kRequestStatusNone;
    [queue setObject:req forKey:[NSNumber numberWithInt:tag]];
    req.enc=enc;
    req.owner=owner;
    req.url=[EDXURIHelper GetUrlForBusiness:tag];
    NSLog(@"%s:%@",__FUNCTION__,req.url);
    [req postJson:json delegate:self];
    if(owner!= nil)[owner beginRequest:tag];
}

- (void)cancel:(kBusinessTag)tag{
    NSLog(@"%s",__func__);
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:tag]];
    if (req && [req isKindOfClass:[EDXNetworkRequest class]]) {
        [req cancel];
    }
}

- (void) dealloc{
    [queue release];
    [super dealloc];
}

#pragma mark ASIHTTPRequest delegate

- (void)requestFinished:(ASIHTTPRequest *)request{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:request.tag]];
    req.requestStatus=kRequestStatusEnded;
    if(req.owner!= nil){
        [req.owner endRequest:req.result business:req.businessTag];
    }
}

- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"%s",__func__);
    NSLog(@"%@",[request description]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:[NSNumber numberWithInt:request.tag]];
    NSError *error = [request error];
    if(req.owner!=nil){
        [req.owner errorRequest:error];
    }
}
@end
