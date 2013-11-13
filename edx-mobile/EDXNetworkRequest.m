//
//  EDXNetworkRequest.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXNetworkRequest.h"
#import "ASIHTTPRequest.h"
@implementation EDXNetworkRequest
{
    ASIHTTPRequest* _request;//use this object to do http request
}
@synthesize enc,url;
@synthesize requestStatus;
@synthesize businessTag;
@synthesize owner;

-(void)cancel{
    if (_request!=nil) {
        [_request release],_request=nil;
    }
}
-(void)setOwner:(id<EDXNetworkDelegate>)_owner{
    owner=[_owner retain];
}
-(id<EDXNetworkDelegate>)owner{
    return owner;
}
-(id)result{
    if(requestStatus==kRequestStatusEnded){
        NSData *data = [_request responseData];
        NSError* error;
        return  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    }else
        return nil;
}
-(void)postJson:(NSString*)json delegate:(id)delegate{
    //cancle unfinished request
    [self cancel];
    _request =[[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]]retain];
    [_request setShouldAttemptPersistentConnection:NO];//Do not reuse HTTP connection
    [_request setResponseEncoding:self.enc];//set response encoding
    NSMutableDictionary* reqHeaders = [[NSMutableDictionary alloc]init];
    [reqHeaders setValue:@"application/json; charset=UTF-8" forKey:@"Content-Type"];
    _request.requestHeaders = reqHeaders; // set header
    [reqHeaders release];
    NSLog(@"post json:%@",json);
    _request.tag=self.businessTag;
    [_request appendPostData:[json dataUsingEncoding:self.enc]];//set post data
    [_request setDelegate:delegate];//set request delegate
    requestStatus = kRequestStatusBeging;// request begin
    [_request startAsynchronous];// start async request
}
-(void)dealloc{
    [owner release],owner=nil;
    [_request release];
    [super dealloc];
}
@end
