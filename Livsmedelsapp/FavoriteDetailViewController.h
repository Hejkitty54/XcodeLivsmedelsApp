//
//  FavoriteDetailViewController.h
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-08.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (nonatomic) NSDictionary *favoriteFood;
@end
