//
//  CompareViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-09.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"
#import <GKBarGraph.h>

@interface CompareViewController : UIViewController <UITableViewDataSource,GKBarGraphDataSource>
+(CompareViewController*)singletonCVC;
@property (nonatomic)NSMutableArray* firstData;
@property (nonatomic)NSMutableArray* secondData;

@end
