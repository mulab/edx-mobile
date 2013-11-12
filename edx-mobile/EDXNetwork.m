//
//  EDXNetwork.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXNetwork.h"
#import "EDXConstants.h"
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
        req.url=[NSString stringWithFormat:loginUrl,api_key];
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
// 请求失败，获取 error
- (void)requestFailed:(ASIHTTPRequest *)request
{
    EDXNetworkRequest* req=(EDXNetworkRequest*)[queue objectForKey:
                                    [NSNumber numberWithInt:request.tag]];
	NSError *error = [request error];
	if (req.owner!=nil) {
        [req.owner errorPost:error
					business: req.businessTag];
    }
}
-(void)dealloc{
    [queue release];
    [super dealloc];
}
@end
