//
//  InvitationCodeViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationCodeViewController : UIViewController<UITextFieldDelegate,ApiRequestDelegate,MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtCode;

@property (weak, nonatomic) IBOutlet UIButton *btnEnter;

@property (weak, nonatomic) IBOutlet UILabel *lblCodetext;

@property (weak, nonatomic) IBOutlet UILabel *lblAppname;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnJoin;

@property (weak, nonatomic) IBOutlet UILabel *lblEmailtext;

- (IBAction)Join_click:(id)sender;

- (IBAction)Submit_click:(id)sender;

@end
