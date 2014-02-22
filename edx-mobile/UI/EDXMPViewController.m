//
//  EDXMPViewController.m
//  edx-mobile
//
//  Created by cissy on 13-12-8.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXMPViewController.h"
#import "EDXAppDelegate.h"
#import "EDXViewController.h"

@interface EDXMPViewController ()

@end

@implementation EDXMPViewController
@synthesize url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPause)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)videoDidPause{
    EDXAppDelegate *app = (EDXAppDelegate *) [[UIApplication sharedApplication] delegate];
    EDXViewController *sp = app.backView;
    UIViewController *nav = sp.childViewControllers[0];
    switch (self.moviePlayer.playbackState){
        case MPMoviePlaybackStatePlaying:{
            [UIView animateWithDuration:0.5 animations:^{
                nav.view.hidden = YES;
            }];
            break;
        }
        case MPMoviePlaybackStatePaused:{
            [UIView animateWithDuration:0.5 animations:^{
                nav.view.hidden = NO;
            }];
            break;
        }
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
