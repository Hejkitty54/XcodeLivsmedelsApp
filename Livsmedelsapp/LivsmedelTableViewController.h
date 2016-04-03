//
//  LivsmedelTableViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "DataViewController.h"
@interface LivsmedelTableViewController : UITableViewController <UISearchResultsUpdating>
@property NSMutableArray *aWholeData;
@property NSMutableArray *aWholeDataNutritions;
@property NSMutableArray *aWholeDataUnit;
@property NSMutableArray *energiData;
+(LivsmedelTableViewController*)singletonTVC;
@property NSString *energi;
@property CustomTableViewCell *cell;
@end
