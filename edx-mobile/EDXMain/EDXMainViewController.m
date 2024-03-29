//
//  EDXMainViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXMainViewController.h"
#import "EDXMPViewController.h"
#import "EDXConstants.h"

@interface EDXMainViewController ()
@end

@implementation EDXMainViewController
@synthesize courseName;
@synthesize showCouseButton;
@synthesize courseURI;
@synthesize videoURI;
@synthesize videoName;
@synthesize showVideoButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        courseURI = [NSMutableArray array];
        videoURI = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[[EDXNetwork sharedEDXNetwork]getBusinessReq:kBusinessTagEnrollCourse owner:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterCourseAction:(id)sender {
    buttonTag=[(UIButton*)sender tag];
}


- (IBAction)showVideoAction:(id)sender {
    NSURL* url = [NSURL URLWithString:[NSString stringWithString:videoURI[[(UIButton*)sender tag]]]];
    EDXMPViewController* mp = [[EDXMPViewController alloc]initWithContentURL:url];
    [self.navigationController pushViewController:mp animated:YES];
}

- (NSString*)GetCouseId{
    return courseURI[0];
}

#pragma mark NetworkModule delegate
-(void) beginPost:(kBusinessTag)tag{
}
-(void) endPost:(id)result business:(kBusinessTag)tag{
    if (tag== kBusinessTagEnrollCourse){
        NSDictionary *response = result;
        if([response objectForKey:@"enrollments"]){
            NSArray *enrolls =  [response objectForKey:@"enrollments"];
            NSLog(@"enrolls:%@",[enrolls[0] objectForKey:@"display_name"]);
            [courseName setText:[enrolls[0] objectForKey:@"display_name"]];
            [showCouseButton setTag:0];
            [courseURI addObject:[NSString stringWithString:[enrolls[0] objectForKey:@"course_id"]]];
        }
    }else if (tag==kBusinessTagGetCourseVideoList){
        NSDictionary *response = result;
        if([[[NSString alloc]initWithString:@"success"] isEqualToString:[response objectForKey:@"status"]]){
            NSArray* videos = [response objectForKey:@"course_videos"];
            [videoName setText:[videos[0] objectForKey:@"display_name"]];
            [showCouseButton setTag:0];
            [videoURI addObject:[NSString stringWithString:[[videos[0] objectForKey:@"sources"]objectForKey:@"alt"][0]]];
            NSLog(@"videoURI:%@",[NSString stringWithString:videoURI[0]]);
        }
    }
}
-(void) errorPost:(NSError *)err{}


@end
