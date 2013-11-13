//
//  EDXLoginViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXLoginViewController.h"
#import "EDXNetwork.h"
#import "EDXConstants.h"
@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
@synthesize userName;
@synthesize password;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any reso      urces that can be recreated.
}

- (IBAction)LoginAction:(id)sender {
    NSString* postData = [NSString stringWithFormat:loginPost,userName.text,password.text];
    [[EDXNetwork sharedEDXNetwork]postBusinessReq:postData tag:kBusinessTagUserLogin owner:self];
}
- (void)dealloc {
    [userName release];
    [password release];
    [super dealloc];
}

#pragma mark NetworkModule delegate 
-(void) beginPost:(kBusinessTag)tag{
}
-(void) endPost:(id)result business:(kBusinessTag)tag{
    UIAlertView *message = nil;
    if(tag==kBusinessTagUserLogin){
        NSDictionary *respond = result;
        if ([[[NSString alloc]initWithString:@"successful"]isEqualToString: [respond objectForKey:@"status"]] == NO) {
            //if not success
            message = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [message show];
            [message release];
        } else {
            //if success
            message = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Login Succeed" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [message show];
            [message release];
        }
    }else{
         message = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [message show];
        [message release];
    }
}
-(void) errorPost:(NSError *)err{
    NSLog(@"err:%@",[err localizedDescription]);
    NSLog(@"reason:%@",[err localizedFailureReason]);
    NSLog(@"suggestion:%@",[err localizedRecoverySuggestion]);
}
@end
