//
//  BillingInfoViewController.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 23/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Stripe.h"

@interface BillingInfoViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UITextField *txtNameOnCard;

@property (weak, nonatomic) IBOutlet UILabel *lblPaymentDetails;

@property (weak, nonatomic) IBOutlet UILabel *lblCardDetails;

@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblExpiration;

@property (weak, nonatomic) IBOutlet UITextField *txtMonth;

@property (weak, nonatomic) IBOutlet UITextField *txtYear;

@property (weak, nonatomic) IBOutlet UILabel *lblCVCode;

@property (weak, nonatomic) IBOutlet UITextField *txtCVCode;

@property (weak, nonatomic) IBOutlet UILabel *lblBilling;

@property (weak, nonatomic) IBOutlet UILabel *lblZipCode;

@property (weak, nonatomic) IBOutlet UITextField *txtZip;

@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;

@property (strong, nonatomic) STPCard* stripeCard;

- (IBAction)btnCancel_Click:(id)sender;

- (IBAction)btnSave_Click:(id)sender;

@end
