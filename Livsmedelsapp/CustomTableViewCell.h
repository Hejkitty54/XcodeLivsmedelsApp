//
//  CustomTableViewCell.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *energi;
@property (weak, nonatomic) IBOutlet UILabel *energiUnit;
@property (weak, nonatomic) IBOutlet UILabel *protein;
@property (weak, nonatomic) IBOutlet UILabel *proteinUnit;
@property (weak, nonatomic) IBOutlet UIImageView *foodImg;



@property NSDictionary *foodData;

@end
