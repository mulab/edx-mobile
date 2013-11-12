//
//  EDXNetwork.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "EDXNetworkRequest.h"
@interface EDXNetwork : NSObject
<ASIHTTPRequestDelegate>{
    NSMutableDictionary* queue;
}
+(EDXNetwork*)sharedEDXNetwork;
-(void)postBusinessReq:(NSString*)json
                   tag:(kBusinessTag)tag
                 owner:(id<EDXNetworkDelegate>)owner;
-(void)cancel:(kBusinessTag)tag;

@end
