//
//  EDXFindCourseViewController.h
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXViewController.h"
#import "EDXMyCourseCell.h"

@class EDXNetworkManager;
@class EDXDataManager;
@interface EDXFindCourseViewController : EDXViewController<UITableViewDelegate, UITableViewDataSource, EDXNetworkDelegate, EDXCourseCellDelegate>
@property (nonatomic, strong) NSMutableArray *courseList;
@property (nonatomic, strong) EDXDataManager *dataManager;
@property (nonatomic, strong) EDXNetworkManager *networkManager;
@property (strong, nonatomic) IBOutlet UITableView *courseTable;
@end
