//
//  EDXCourseDetailViewController.h
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXViewController.h"
#import "CollapsableTableViewDelegate.h"
#import "EDXDataManager.h"
#import "EDXNetworkManager.h"
@class EDXCourseDetailModel;

@interface EDXCourseDetailViewController : EDXViewController<UITableViewDelegate,UITableViewDataSource,CollapsableTableViewDelegate,EDXNetworkDelegate>
@property (nonatomic, retain)NSString *courseId;
@property (nonatomic, strong)EDXDataManager *dataManager;
@property (nonatomic, strong)EDXNetworkManager *networkManager;
@property (nonatomic, strong)EDXCourseDetailModel *courseDetail;
@property (strong, nonatomic) IBOutlet CollapsableTableView *navigateView;
- (IBAction)back:(id)sender;
@end
