//
//  EDXVideoItemModel.h
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXItemModel.h"

@interface EDXVideoItemModel : EDXItemModel<NSCoding>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *transcript;
@end
