//
//  TPMasterViewController.m
//  TreePop
//
//  Created by Nick Martin on 2/24/14.
//  Copyright (c) 2014 MonkeyMan. All rights reserved.
//

#import "TPMasterViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface TPMasterViewController () {
    NSMutableArray *_artists;
}
@end

@implementation TPMasterViewController

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

- (void)updateArtistList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.kimonolabs.com/api/e1d6376a?apikey=17f07be1fa51fb9ee534beac571794b6" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *results = responseObject[@"results"];
        NSArray *collection = results[@"collection1"];
        for(NSDictionary *artist in collection){
            NSDictionary *artistInfo = artist[@"Artist"];
            [_artists addObject:artistInfo[@"text"]];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];

    NSDate *object = _artists[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
