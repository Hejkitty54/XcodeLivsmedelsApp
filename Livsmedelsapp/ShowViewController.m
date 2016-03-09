//
//  ShowViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "ShowViewController.h"
#import "DataViewController.h"
#import "FavoriteTableViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController{
    int num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataViewController* d =[[DataViewController alloc]init];
    
    // get a number from saved dictionary @{name number}
    num = [[self.oneFood objectForKey:@"number"] intValue];
    
    // shows detail
    [d getDetailWithNumber:num uiVC:self];
  
    
}

- (IBAction)isFavorite:(id)sender {
  
    // if favorite is on it is added to favorites list in Favorite table view.
    if (self.isFavorite.on) {
        
        NSDictionary* foodObject = @{@"name":self.title,@"number":[NSString stringWithFormat:@"%d",num]};
          
        [[FavoriteTableViewController singletonFav].favorites addObject:foodObject];
        
        [[FavoriteTableViewController singletonFav].tableView reloadData];
        
        NSLog(@"favorite %@ is added",self.title);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
