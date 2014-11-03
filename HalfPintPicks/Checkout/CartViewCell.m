//
//  CartViewCell.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/22/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "CartViewCell.h"

@implementation CartViewCell
@synthesize lblCurrentPrice,lblOriginalPrice,lblProductName,lblProductSize,imgProduct;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
