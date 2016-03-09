//
//  SaveLoadViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-09.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "SaveLoadViewController.h"

@interface SaveLoadViewController ()

@end

@implementation SaveLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)save{
    NSLog(@"save");
    NSUserDefaults *settings =[NSUserDefaults standardUserDefaults];
    
    FavoriteTableViewController *fav = [FavoriteTableViewController singletonFav];
    [settings setObject:fav.favorites.copy forKey:@"savedlist"];
    
    [settings synchronize];
}


-(void)load{
    NSLog(@"load");
    NSUserDefaults *settings =[NSUserDefaults standardUserDefaults];
    
    NSArray* savedlist = [settings objectForKey:@"savedlist"];
    NSMutableArray* savedMutableList = savedlist.mutableCopy;
    
    if (savedlist.count>0) {
        NSString* s = [savedlist[0] objectForKey:@"name"];
        NSLog(@"load %@",s);
    }
    
    [FavoriteTableViewController singletonFav].favorites = savedMutableList;
    
    
    
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
