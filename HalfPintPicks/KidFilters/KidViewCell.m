//
//  KidViewCell.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "KidViewCell.h"

@implementation KidViewCell
@synthesize lblAge,lblAgevalue,lblClothsize,lblClothvalue,lblFullname,lblGender,lblGendervalue,lblShoessize,lblShoesvalue,imgKid,btnClose;

- (void)awakeFromNib {
    // Initialization code
    imgKid.layer.borderWidth = 1.0f;
    imgKid.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgKid.layer.cornerRadius = 30.0f;
    imgKid.layer.masksToBounds =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Close_Click:(id)sender {
}
@end
