//
//  KidViewCell.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KidViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblFullname;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblAgevalue;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblGendervalue;
@property (weak, nonatomic) IBOutlet UILabel *lblClothsize;
@property (weak, nonatomic) IBOutlet UILabel *lblClothvalue;
@property (weak, nonatomic) IBOutlet UILabel *lblShoessize;
@property (weak, nonatomic) IBOutlet UILabel *lblShoesvalue;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet EGOImageView *imgKid;

- (IBAction)Close_Click:(id)sender;
@end
