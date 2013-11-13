//
//  EDXNetworkDelegate.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
enum kRequestStatus{//the status define of a request
    kRequestStatusNone=0,
    kRequestStatusBeging=1,
    kRequestStatusEnded=2,
    kRequestStatusError=3,
    kRequestStatusReceiving=4
};
typedef enum kRequestStatus kRequestStatus;
enum kBusinessTag//the request tag
{
    kBusinessTagGetStatus=0,
	kBusinessTagUserLogin=1,
    kBusinessTagGetEnrollments=2,
};
typedef enum kBusinessTag kBusinessTag;
@protocol EDXNetworkDelegate <NSObject>
@optional
-(void)beginPost:(kBusinessTag)tag;
-(void)endPost:(NSData*)result business:(kBusinessTag)tag;
-(void)errorPost:(NSError*)err;
@end
