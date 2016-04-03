//
//  FavoriteTableViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-06.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteDetailViewController.h"

@interface FavoriteTableViewController ()
@end

@implementation FavoriteTableViewController

+(FavoriteTableViewController*)singletonFav{
    
    static FavoriteTableViewController *theFav = nil;
    
    if(!theFav){
        theFav = [[super allocWithZone:nil]init];
    }
    return theFav;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self singletonFav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!_favorites){
        _favorites = [[NSMutableArray alloc]init];
    }
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray*) favorites {
    if(!_favorites) {
        _favorites  = [[NSMutableArray alloc] init];
    }
    return _favorites;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
    
    cell.textLabel.text=[self.favorites[[indexPath row]] objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.numberOfLines=3;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove the row from data model
    [self.favorites removeObjectAtIndex:indexPath.row];
    // Request table view to reload
    [tableView reloadData];
    
 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    
}*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    FavoriteDetailViewController* fvc = segue.destinationViewController;
    UITableViewCell *cell = sender;
    
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    NSDictionary *favoriteFood = self.favorites[path.row];
    
    fvc.favoriteFood= favoriteFood;
    fvc.aWholeDataUnit= self.aWholeDataUnit;
    
    fvc.title = favoriteFood[@"name"];
  
}


@end
