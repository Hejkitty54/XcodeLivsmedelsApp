//
//  AboutViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-04-02.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UITextView *about;
@property (weak, nonatomic) IBOutlet UITextView *favorites;
@property (weak, nonatomic) IBOutlet UITextView *compare;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.about.scrollEnabled= NO;
    self.favorites.scrollEnabled= NO;
    self.compare.scrollEnabled= NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.about.scrollEnabled =YES;
    self.favorites.scrollEnabled =YES;
    self.compare.scrollEnabled =YES;
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
