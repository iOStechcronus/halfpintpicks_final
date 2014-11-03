//
//  CartViewCell.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/22/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductSize;
@property (weak, nonatomic) IBOutlet UILabel *lblOriginalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentPrice;

@end
