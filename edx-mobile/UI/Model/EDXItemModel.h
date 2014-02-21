//
//  EDXItemModel.h
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDXItemModel : NSObject<NSCoding>
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *displayName;
@property (nonatomic, strong)NSString *location;
@end
