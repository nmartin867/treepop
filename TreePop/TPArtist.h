//
//  TPArtist.h
//  TreePop
//
//  Created by Nick Martin on 3/7/14.
//  Copyright (c) 2014 org.monkeyman.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPArtist : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, strong) UIImage *image;
@end
