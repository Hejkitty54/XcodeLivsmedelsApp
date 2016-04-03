//
//  FavoriteDetailViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-08.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *protein;
@property (weak, nonatomic) IBOutlet UILabel *fat;
@property (weak, nonatomic) IBOutlet UILabel *vitaminC;
@property (weak, nonatomic) IBOutlet UILabel *salt;
@property (weak, nonatomic) IBOutlet UILabel *zink;
@property (weak, nonatomic) IBOutlet UILabel *proteinUnit;
@property (weak, nonatomic) IBOutlet UILabel *fatUnit;
@property (weak, nonatomic) IBOutlet UILabel *vitaminCUnit;
@property (weak, nonatomic) IBOutlet UILabel *saltUnit;
@property (weak, nonatomic) IBOutlet UILabel *zinkUnit;
@property (weak, nonatomic) IBOutlet UILabel *healthy;
@property (nonatomic) NSDictionary *favoriteFood;
@property NSMutableArray *aWholeDataUnit;
@end
