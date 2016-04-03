//
//  ShowViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *foodImg;
@property (weak, nonatomic) IBOutlet UILabel *protein;
@property (weak, nonatomic) IBOutlet UILabel *fat;
@property (weak, nonatomic) IBOutlet UILabel *vitamin;
@property (weak, nonatomic) IBOutlet UILabel *salt;
@property (weak, nonatomic) IBOutlet UILabel *zink;
@property (weak, nonatomic) IBOutlet UILabel *proteinUnit;
@property (weak, nonatomic) IBOutlet UILabel *fatUnit;
@property (weak, nonatomic) IBOutlet UILabel *vitaminCUnit;
@property (weak, nonatomic) IBOutlet UILabel *saltUnit;
@property (weak, nonatomic) IBOutlet UILabel *zinkUnit;
@property (weak, nonatomic) IBOutlet UILabel *calculate;
@property(nonatomic) NSString* number;
@property NSDictionary *oneFood;
@property (weak, nonatomic) IBOutlet UISwitch *isFavorite;
@property NSMutableArray *aWholeDataUnit;
@end
