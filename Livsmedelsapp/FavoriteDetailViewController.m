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
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic)UICollisionBehavior *collision;
@property (weak, nonatomic) IBOutlet UILabel *starLeft;
@property (weak, nonatomic) IBOutlet UILabel *starRight;

@end

@implementation FavoriteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dropSquare:@"Left"];
    [self dropSquare:@"Left"];
    [self dropSquare:@"Left"];
    [self dropSquare:@"Right"];
    [self dropSquare:@"Right"];
    [self dropSquare:@"Right"];
    
    [[UITabBar appearance] setBarTintColor:[UIColor redColor]];
    //[[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    
    DataViewController* d = [[DataViewController alloc]init];
    [d getDetailWithNumber:[[self.favoriteFood objectForKey:@"number"] intValue] uiVC:self];
    
    
    //set unit
    NSDictionary* getProteinUnit;
    NSDictionary* getFatUnit;
    NSDictionary* getVitaminCUnit;
    NSDictionary* getSaltUnit;
    NSDictionary* getZinkUnit;
    
    
    for(NSDictionary* dict in self.aWholeDataUnit)
    {
        if([[dict objectForKey:@"slug"] isEqualToString: @"protein"])
        {
            getProteinUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"fat"])
        {
            getFatUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"vitaminC"])
        {
            getVitaminCUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"salt"])
        {
            getSaltUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"zink"])
        {
            getZinkUnit= dict;
        }
    }
    
    self.proteinUnit.text = [getProteinUnit objectForKey:@"unit"];
    self.fatUnit.text = [getFatUnit objectForKey:@"unit"];
    self.vitaminCUnit.text =[getVitaminCUnit objectForKey:@"unit"];
    self.saltUnit.text =[getSaltUnit objectForKey:@"unit"];
    self.zinkUnit.text =[getZinkUnit objectForKey:@"unit"];
    
    
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.starLeft.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    [self.starRight.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIDynamicAnimator*)animator{
    if (!_animator) {
        _animator =[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

-(UIGravityBehavior*)gravity{
    if (!_gravity) {
        _gravity =[[UIGravityBehavior alloc]init];
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

-(UICollisionBehavior*)collision{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc]init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

- (IBAction)tapLeft:(UITapGestureRecognizer *)sender {
    [self dropSquare:@"Left"];
}
- (IBAction)tapRight:(UITapGestureRecognizer *)sender {
    [self dropSquare:@"Right"];
}


-(void)dropSquare:(NSString*)RorL {
    
    CGFloat width = self.view.frame.size.width;
    
    UIView* square =[[UIView alloc]initWithFrame:CGRectMake(20, 20, 16, 16)];
    [square setBackgroundColor:[UIColor orangeColor]];
    
        // 左たっぷすると左から四角が。右タップすると右から四角が。
        if ([RorL isEqualToString:@"Left"]) {
            square.center = CGPointMake(10, 50);
        } else{
            square.center = CGPointMake(width-10, 50);
        }
    
    [self.view addSubview:square];
    
    // add behavior
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    
    [self.gravity addItem:square];
    [self.collision addItem:square];
    
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
