//
//  DataTestViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-02.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivsmedelTableViewController.h"
#import "ShowViewController.h"
#import "FavoriteTableViewController.h"
#import "FavoriteDetailViewController.h"
#import "CompareViewController.h"
@interface DataViewController : UIViewController
-(void)getAllData;
-(void)getUnit;
-(void) getDetailWithNumberForCell:(int)number cell:(CustomTableViewCell*)cell;
-(void) getDetailWithNumber:(int)number uiVC:(UIViewController*)vc;
-(void) getFirstInfoWithNumber:(int)number;
-(void) getSecondInfoWithNumber:(int)number;
@end
