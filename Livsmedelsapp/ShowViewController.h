//
//  ShowViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController
+(ShowViewController*)singletonSVC;
@property (weak, nonatomic) IBOutlet UILabel *protein;
@property (weak, nonatomic) IBOutlet UILabel *fat;
@property (weak, nonatomic) IBOutlet UILabel *vitamin;
@property(nonatomic) NSString* number;
@property NSDictionary *oneFood;

@end
