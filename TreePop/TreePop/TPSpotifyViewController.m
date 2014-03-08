//
//  TPSpotifyViewController.m
//  TreePop
//
//  Created by Nick Martin on 3/7/14.
//  Copyright (c) 2014 org.monkeyman.com. All rights reserved.
//

#import "TPSpotifyViewController.h"
#import "CocoaLibSpotify.h"

@interface TPSpotifyViewController ()

@end

@implementation TPSpotifyViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    SPLoginViewController *spController = [SPLoginViewController loginControllerForSession:[SPSession sharedSession]];
	spController.allowsCancel = YES;
    [self presentViewController:spController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
