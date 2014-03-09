//
//  TPMasterViewController.m
//  TreePop
//
//  Created by Nick Martin on 3/7/14.
//  Copyright (c) 2014 org.monkeyman.com. All rights reserved.
//

#import "TPMasterViewController.h"
#import "TPDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "TPArtist.h"

@interface TPMasterViewController () {
    NSMutableArray *_artists;
}
@end

@implementation TPMasterViewController

static const NSString *ServiceBaseURL = @"http://buggylist.com:3000";

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _artists = [NSMutableArray array];
    [self updateArtistList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getArtistsFromSearchResults:(id)searchResponse{
    for(NSDictionary *musician in searchResponse){
        TPArtist *artist = [TPArtist new];
        artist.name = musician[@"name"];
        artist.imageUrl = [NSString stringWithFormat:@"%@/image/%@", ServiceBaseURL, musician[@"imageFile"]];
        artist.city = musician[@"city"];
        [_artists addObject:artist];
    }
}

- (void)updateArtistList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://buggylist.com:3000" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getArtistsFromSearchResults:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self displayErrorMessage:error];
    }];
}

#pragma mark - Image Download

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES, image);
                               } else{
                                   completionBlock(NO, nil);
                               }
                           }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ArtistCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    TPArtist *artist = [_artists objectAtIndex:[indexPath row]];
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = artist.city;
    if(!cell.imageView.image){
        [self downloadImageWithURL:[NSURL URLWithString:artist.imageUrl] completionBlock:^(BOOL succeeded, UIImage *image){
            if (succeeded) {
                // change the image in the cell
                cell.imageView.image = image;
                // cache the image for use later (when scrolling up)
                artist.image = image;
                //update cell with icon
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
            }
        }];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

-(void)displayErrorMessage:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:error.description
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

@end
