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
#import "FavoriteDetailViewController.h"
@interface DataViewController : UIViewController
-(void)getAllData;
-(void) getDetailWithNumber:(int)number uiVC:(UIViewController*)vc;
-(void) getDetailWithNumberForCell:(int)number cell:(CustomTableViewCell*)cell;
-(void) sendDetailWithNumber:(int)number;
@property(nonatomic)NSString *testString;
@end
