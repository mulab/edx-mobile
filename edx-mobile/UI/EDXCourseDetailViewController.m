//
//  EDXCourseDetailViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/22/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXCourseDetailViewController.h"
#import "CollapsableTableView.h"
#import "EDXCourseDetailModel.h"
#import "EDXChapterModel.h"
#import "EDXSubChapterModel.h"
#import <Objection/Objection.h>
#import "EDXAppDelegate.h"
#import "EDXItemModel.h"
#import "EDXVideoItemModel.h"
#import "EDXMPViewController.h"
#import "EDXNetworkManager.h"

@interface EDXCourseDetailViewController ()

@end

@implementation EDXCourseDetailViewController
objection_requires_sel(@selector(dataManager), @selector(networkManager));
@synthesize courseId,dataManager,networkManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        EDXAppDelegate *app = (EDXAppDelegate *) [[UIApplication sharedApplication] delegate];
        self.courseId = app.currentCourse;
        self.dataManager = [[JSObjection defaultInjector] getObject:[EDXDataManager class]];
        self.courseDetail = [self.dataManager getCourseDetail:self.courseId];
        [self.networkManager GetCourseDetail:self.courseId owner:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CollapsableTableView* tableView = self.navigateView;
    tableView.collapsableTableViewDelegate = self;
    tableView.sectionsInitiallyCollapsed = YES;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)before:(kBusinessTag)tag {

}

- (void)success:(id)result business:(kBusinessTag)tag {
    [self.dataManager saveCourseDetail:result];
    self.courseDetail = [self.dataManager getCourseDetail:self.courseId];
    [self.navigateView reloadData];
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.courseDetail.children.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    EDXChapterModel *chapterModel = [self.courseDetail.children objectAtIndex:(NSUInteger) section];
    if(chapterModel == nil)return 0;
    return chapterModel.children.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    EDXChapterModel *chapterModel = [self.courseDetail.children objectAtIndex:(NSUInteger) section];
    if(chapterModel== nil)return @"";
    return chapterModel.displayName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    EDXChapterModel *chapterModel = [self.courseDetail.children objectAtIndex:(NSUInteger) indexPath.section];
    if(chapterModel == nil)return cell;
    EDXSubChapterModel *subChapterModel = [chapterModel.children objectAtIndex:(NSUInteger) indexPath.row];
    if(subChapterModel == nil)return cell;
    cell.textLabel.text = subChapterModel.displayName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EDXChapterModel *chapterModel = [self.courseDetail.children objectAtIndex:(NSUInteger) indexPath.section];
    if(chapterModel){
        EDXSubChapterModel *subChapterModel = [chapterModel.children objectAtIndex:(NSUInteger) indexPath.row];
        if(subChapterModel){
            for(EDXItemModel *item in subChapterModel.children){
                if([item.type isEqualToString: @"video"]){
                    EDXVideoItemModel *video = (EDXVideoItemModel *) item;
                    EDXAppDelegate *app = (EDXAppDelegate *) [[UIApplication sharedApplication] delegate];
                    UIViewController *sp = app.backView;
                    EDXMPViewController *mp = sp.childViewControllers[1];
                    [mp.moviePlayer setContentURL:[[NSURL alloc] initWithString:video.url]];
                    [mp.moviePlayer play];
                }
            }
        }
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
