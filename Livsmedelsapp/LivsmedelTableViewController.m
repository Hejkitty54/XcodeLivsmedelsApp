//
//  LivsmedelTableViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "LivsmedelTableViewController.h"
#import "ShowViewController.h"

@interface LivsmedelTableViewController ()
@property(nonatomic) NSMutableArray *testData;
@property(nonatomic) NSDictionary *testUnit;
@end

@implementation LivsmedelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testData=@[@{@"name":@"Carrot",@"energi":@"250",@"protein":@"2.6",@"fat":@"3.4"},
                    @{@"name":@"Onion",@"energi":@"20",@"protein":@"1",@"fat":@"1.2"},
                    @{@"name":@"Pork",@"energi":@"500",@"protein":@"5.6",@"fat":@"56"},
                    @{@"name":@"Tomato",@"energi":@"25",@"protein":@"3",@"fat":@"2"}
                    ].mutableCopy;
    
    self.testUnit=@{@"energi":@"%",@"protein":@"g",@"fat":@"cal"};
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

    return self.testData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"myCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    NSDictionary *oneDictionary = self.testData[[indexPath row]];
    NSString *oneName = [oneDictionary objectForKey:@"name"];
    NSString *oneEnergi = [oneDictionary objectForKey:@"energi"];
    NSString *oneProtein = [oneDictionary objectForKey:@"protein"];
    cell.foodName.text = oneName;
    cell.energi.text= oneEnergi;
    cell.protein.text=oneProtein;
    
    // sets units
    NSString *energiUnit =[self.testUnit objectForKey:@"energi"];
    NSString *proteinUnit =[self.testUnit objectForKey:@"protein"];
    cell.energiUnit.text = energiUnit;
    cell.proteinUnit.text= proteinUnit;
    return cell;
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
        UITableViewCell *cell = sender;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        NSDictionary *positionFood = self.testData[path.row];
        NSString *oneName = [positionFood objectForKey:@"name"];
        showViewController.title = oneName;
        
    } else if([segue.identifier isEqualToString:@"favorites"]){
    
    }else{
        
        assert(NO);
    }
}


@end
