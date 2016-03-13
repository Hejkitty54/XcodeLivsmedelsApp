//
//  SaveLoadViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-09.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteTableViewController.h"

@interface SaveLoadViewController : UIViewController
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
-(void)save;
-(void)load;
@end
