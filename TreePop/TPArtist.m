//
//  TPArtist.m
//  TreePop
//
//  Created by Nick Martin on 3/7/14.
//  Copyright (c) 2014 org.monkeyman.com. All rights reserved.
//

#import "TPArtist.h"

@implementation TPArtist
-(NSString *)description{
    NSDictionary *classDesc =  @{@"Name" : _name, @"City" : _city, @"ImageUrl" : _imageUrl};
    return [classDesc description];
}
@end
