//
//  FavoriteTableViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-06.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewController : UITableViewController
@property (nonatomic) NSMutableArray* favorites;
+(FavoriteTableViewController*)singletonFav;
@end
