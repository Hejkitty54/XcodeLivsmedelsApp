//
//  FavoriteDetailViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-08.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "FavoriteDetailViewController.h"
#import "DataViewController.h"

@interface FavoriteDetailViewController ()


@end

@implementation FavoriteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataViewController* d = [[DataViewController alloc]init];
    [d getDetailWithNumber:[[self.favoriteFood objectForKey:@"number"] intValue] uiVC:self];
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
