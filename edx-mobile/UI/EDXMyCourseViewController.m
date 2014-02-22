//
//  EDXMyCourseViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXMyCourseViewController.h"
#import "EDXMyCourseCell.h"
#import "EDXDataManager.h"
#import "EDXCourseDetailViewController.h"
#import "EDXMPViewController.h"
#import "EDXAppDelegate.h"

@interface EDXMyCourseViewController ()
- (void)navigateToCourseDetail:(NSString *)courseId;
@end
static EDXMyCourseViewController *instance = nil;
@implementation EDXMyCourseViewController
objection_requires_sel(@selector(dataManager), @selector(networkManager));
@synthesize dataManager,networkManager,myCourseList,myCourseTable;
- (id)init {
    self = [super init];
    if (self) {
        networkManager = [[JSObjection defaultInjector] getObject:[EDXNetworkManager class]];
        dataManager = [[JSObjection defaultInjector] getObject:[EDXDataManager class]];
        instance = self;
    }

    return self;
}

+ (instancetype) getInstance{
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *barItemImage = [UIImage imageNamed:@"tab_bar_item_my_course.png"];
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"我的课程" image:barItemImage tag:0];
        self.tabBarItem = barItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myCourseList = [self.dataManager getMyCourseList];
    [self.myCourseTable reloadData];
    [self refreshView];
}

- (void)refreshView {
    [self.networkManager GetEnrollCourseFor:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark EDXNetworkDelegate
- (void)before:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetEnrolls:
            break;
        default:
            break;
    }
}

- (void)success:(id)result business:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetEnrolls:
            [dataManager saveMyCourseList:result];
            myCourseList = [dataManager getMyCourseList];
            [myCourseTable reloadData];
            break;
        case kBusinessTagGetCourseNavigation:
            [dataManager saveCourseDetail:result];
            [self navigateToCourseDetail:[[result objectForKey:@"course"] objectForKey:@"course_id"]];
            break;
        default:
            break;
    }
}

- (void)navigateToCourseDetail:(NSString *)courseId{
    EDXAppDelegate *app = (EDXAppDelegate *) [[UIApplication sharedApplication] delegate];
    app.currentCourse = courseId;
    EDXCourseDetailViewController *courseDetailViewController = [[EDXCourseDetailViewController alloc] init];
    EDXMPViewController *edxMPViewController = [[EDXMPViewController alloc] init];
    UIViewController* splitVC = [[UIViewController alloc] init];
    [splitVC addChildViewController:courseDetailViewController];
    [splitVC addChildViewController:edxMPViewController];
    courseDetailViewController.view.frame = CGRectMake(0, 0, 265, 1004);
    [splitVC.view addSubview:edxMPViewController.view];
    [splitVC.view addSubview:courseDetailViewController.view];
    [self presentViewController:splitVC animated:YES completion:nil];
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {

}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myCourseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myCourseCell = @"myCourseCell";
    EDXMyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:myCourseCell];
    if(cell == nil){
        cell = [[EDXMyCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCourseCell];
    }
    EDXCourseModel *model = (EDXCourseModel *) [self.myCourseList objectAtIndex:(NSUInteger) indexPath.row];
    [cell setupCell:model type:MyCourseCell];
    cell.container = self;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 184.0f;
}


@end
