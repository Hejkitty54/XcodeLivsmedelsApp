//
//  LivsmedelTableViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "LivsmedelTableViewController.h"
#import "ShowViewController.h"
#import "DataViewController.h"

@interface LivsmedelTableViewController ()

@property UISearchController *searchController;
@property NSArray *searchResult;
@end

@implementation LivsmedelTableViewController

+(LivsmedelTableViewController*)singletonTVC{

    static LivsmedelTableViewController *theTVC = nil;
    
    if(!theTVC){
        theTVC = [[super allocWithZone:nil]init];
    }
    
    return theTVC;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self singletonTVC];
}

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get data
    DataViewController *dataViewController =[[DataViewController alloc]init];
    
    if (!_aWholeData) {
        _aWholeData= [[NSMutableArray alloc]init];

    }
    if (!_energiData) {
        _energiData= [[NSMutableArray alloc]init];
        
    }
    //get all data
    [dataViewController getAllData];
 
    
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString* seachText = searchController.searchBar.text;
    
    NSPredicate *findFoodWithName = [NSPredicate predicateWithFormat:@"name contains[c] %@",seachText];
    
    self.searchResult = [self.aWholeData filteredArrayUsingPredicate:findFoodWithName];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if(self.searchController.isActive&&self.searchController.searchBar.text.length > 0){
         return self.searchResult.count;
    }else{
    
        return self.aWholeData.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DataViewController* dataViewController =[[DataViewController alloc]init];
    
    
    static NSString *cellIdentifier = @"myCell";
    
    _cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!_cell)
    {
        _cell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    NSDictionary *activeFood;
    
    if(self.searchController.isActive&&self.searchController.searchBar.text.length > 0){
        activeFood = self.searchResult[[indexPath row]];
        
    }else{

        activeFood = self.aWholeData[[indexPath row]];
       
    }
    NSString *getFoodName = [activeFood objectForKey:@"name"];
    NSString *getFoodNumber = [activeFood objectForKey:@"number"];
    NSLog(@"%@",getFoodName);
    NSLog(@"%@",getFoodNumber);
    
    
    //[dataViewController getDetailWithNumberForCell:[getFoodNumber intValue]];
    //[self.tableView reloadData];
    

    
    // memo number? 場所じゃなくて番号
    _cell.foodName.text = getFoodName;
    //_cell.energi.text = [NSString stringWithFormat:@"%@",getFoodNumber];
    [dataViewController getDetailWithNumberForCell:[getFoodNumber intValue]];
    
    
    
    _cell.foodData = activeFood;
    return _cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    
    ShowViewController *showViewController = segue.destinationViewController;
   
    
    if([segue.identifier isEqualToString:@"show"]){
        CustomTableViewCell *cell = sender;
        
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        NSDictionary *positionFood = self.aWholeData[path.row];
        //NSString *oneName = [positionFood objectForKey:@"name"];
        
        showViewController.oneFood= positionFood;
        
        showViewController.title = cell.foodData[@"name"];
        
        
    }
    
    else{
        
        assert(NO);
    }
}


@end
