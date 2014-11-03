//
//  CartShippingIViewController.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/22/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartShippingIViewController : UIViewController<ApiRequestDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *mainContainerView;

@property (weak, nonatomic) IBOutlet UILabel *lblInstruction;
- (IBAction)btnCheckout_Click:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckout;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

- (IBAction)Back_Click:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterName;

@property (weak, nonatomic) IBOutlet UILabel *lblAddressOne;

@property (weak, nonatomic) IBOutlet UITextField *txtStreetAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblAddressTwo;

@property (weak, nonatomic) IBOutlet UITextField *txtAddressTwo;

@property (weak, nonatomic) IBOutlet UILabel *lblCity;

@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UILabel *lblState;

@property (weak, nonatomic) IBOutlet UITextField *txtEnterState;

@property (weak, nonatomic) IBOutlet UILabel *lblZip;

@property (weak, nonatomic) IBOutlet UITextField *txtEnterZip;
@end
