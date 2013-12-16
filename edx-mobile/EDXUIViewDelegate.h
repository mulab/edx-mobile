//
//  EDXUIViewDelegate.h
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EDXUIViewDelegate <NSObject>
@optional
-(void)BeforeRefreshView;
-(void)RefreshView;
-(void)CancelBeforeRefreshFinished;
-(void)RaiseRequest;
@end
