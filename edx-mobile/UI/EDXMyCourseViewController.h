//
//  EDXMyCourseViewController.h
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXViewController.h"
#import "EDXNetworkDelegate.h"

@class EDXNetworkManager;
@class EDXDataManager;

@interface EDXMyCourseViewController : EDXViewController<UITableViewDelegate, UITableViewDataSource, EDXNetworkDelegate>
{
}
@property (nonatomic, strong) EDXDataManager *dataManager;
@property (nonatomic, strong) EDXNetworkManager *networkManager;
@property (strong, nonatomic) IBOutlet UITableView *myCourseTable;
@property (nonatomic, strong) NSMutableArray *myCourseList;

+ (instancetype)getInstance;
- (void)navigateToCourseDetail:(NSString *)courseId;
- (void)refreshView;
@end
