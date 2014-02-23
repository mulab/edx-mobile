//
//  EDXLoginViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXLoginViewController.h"
#import <Objection/Objection.h>
#import "EDXMainViewController.h"
#import "EDXAppDelegate.h"

@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
objection_requires_sel(@selector(dataManager), @selector(networkManager));
@synthesize userName;
@synthesize password;
@synthesize dataManager,networkManager;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

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
    networkManager = [[JSObjection defaultInjector] getObject:[EDXNetworkManager class]];
    dataManager = [[JSObjection defaultInjector] getObject:[EDXDataManager class]];
    [userName setText:[dataManager GetUserName]];
    NSLog(@"token:%@",[dataManager getAccessToken]);
    NSString *token = [self.dataManager getAccessToken];
    if(token){
        [networkManager setAccess_token:token];
        [self navigateToMainView:NO];
    }
    self.userName.delegate = self;
    self.password.delegate = self;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
//    EDXSignUpData data = {"user@user.com","username","password","user_full"};
//    NSString *url = [[[networkManager SignUpRequestWithData:data] URL] absoluteString];
    //[userName setText:[[[factory SignUpRequestWithData:data] URL] absoluteString]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:out_register_url]];
}

- (IBAction)LoginAction:(id)sender {
    EDXLoginData data = {
            client_id,
            client_secret,
            grant_type,
            [userName.text cStringUsingEncoding:NSUTF8StringEncoding],
            [password.text cStringUsingEncoding:NSUTF8StringEncoding]
    };
    [networkManager LoginWith:data owner:self];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(-120.0f,0.0f,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,0.0f,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}

-(void)hideKeyboard
{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    [self resumeView];
}

#pragma mark EDXNetworkDelegate
- (void)before:(kBusinessTag)tag {

}

- (void)success:(id)result business:(kBusinessTag)tag {
    NSLog(@"result:%@",result);
    if(tag==kBusinessTagUserLogin){
        [dataManager saveAccessToken:[result objectForKey:@"access_token"]];
        NSLog(@"token:%@",[dataManager getAccessToken]);
        [networkManager setAccess_token:[result objectForKey:@"access_token"]];
        [self navigateToMainView:YES];
    }
}

- (void)navigateToMainView:(BOOL)animated {
    EDXMainViewController *mainViewController = [[EDXMainViewController alloc] init];
    if(animated){
        [self presentViewController:mainViewController animated:YES completion:nil];
    } else{
        EDXAppDelegate *app = (EDXAppDelegate *) [[UIApplication sharedApplication] delegate];
        app.window.rootViewController = mainViewController;
    }
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {
}
@end
