//
//  TPDetailViewController.h
//  TreePop
//
//  Created by Nick Martin on 3/7/14.
//  Copyright (c) 2014 org.monkeyman.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
