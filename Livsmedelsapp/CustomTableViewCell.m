//
//  CustomTableViewCell.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    self.foodImg.layer.cornerRadius = self.foodImg.frame.size.height /2;
    self.foodImg.layer.masksToBounds = YES;
    self.foodImg.layer.borderWidth = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
