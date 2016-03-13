//
//  SaveLoadViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-09.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "SaveLoadViewController.h"

@interface SaveLoadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cherry;

@end

@implementation SaveLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
}
-(void)viewDidLayoutSubviews{
    
    UIView* square =[[UIView alloc]initWithFrame:CGRectMake(10, 10, 6, 6)];
    [square setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:square];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[square]];
    
    // add behavior
    [self.animator addBehavior:self.gravity];


}
- (IBAction)onTap:(UITapGestureRecognizer*)sender {
    
    CGPoint touchPosition = [sender locationInView:self.view];
    
    float diffX = touchPosition.x - self.cherry.center.x;
    float diffY = touchPosition.y - self.cherry.center.y;
    float distance = sqrt(diffX*diffX + diffY*diffY);
    float t = distance/300.0f;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:t];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.cherry.center = touchPosition;
    
    [UIView commitAnimations];
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
