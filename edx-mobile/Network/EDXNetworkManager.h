//
//  EDXNetworkManager.h
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SynthesizeSingleton.h"
#import "EDXNetworkDelegate.h"
#import "EDXNetworkRequest.h"
#import <Objection/Objection.h>
@interface EDXNetworkManager : NSObject
<ASIHTTPRequestDelegate>{
    NSMutableDictionary* queue;
}
@property (assign)NSStringEncoding enc;
-(void)cancel:(kBusinessTag)tag;
-(void)getBusinessReq:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner;
-(void)postBusinessReq:(NSString*)json
                   tag:(kBusinessTag)tag
                 owner:(id<EDXNetworkDelegate>)owner;
@end
