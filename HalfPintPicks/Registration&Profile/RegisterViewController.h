//
//  RegisterViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,ApiRequestDelegate,MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) IBOutlet UILabel *lblInfoText;

@property (strong, nonatomic) IBOutlet UILabel *lblApptitle;

@property (strong, nonatomic) IBOutlet UIButton *btnClose;

@property (strong, nonatomic) IBOutlet UIButton *btnJoin;

- (IBAction)Join_Click:(id)sender;

- (IBAction)Close_click:(id)sender;

@end
