//
//  ShippingInfoViewController.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 19/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingInfoViewController : UIViewController <UIScrollViewDelegate, MBProgressHUDDelegate, UITextFieldDelegate,UIScrollViewDelegate,ApiRequestDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *mainContainerView;

@property (weak, nonatomic) IBOutlet UILabel *lblInstruction;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

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

- (IBAction)btnCancel_Click:(id)sender;

- (IBAction)btnSave_Click:(id)sender;

@end
