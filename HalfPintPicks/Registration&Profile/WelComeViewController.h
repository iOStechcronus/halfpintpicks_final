//
//  WelComeViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface WelComeViewController : UIViewController <MBProgressHUDDelegate, FBLoginViewDelegate, UIScrollViewDelegate,ApiRequestDelegate> {
    IBOutlet UIButton *btnLoginFacebook;
    IBOutlet UIButton *btnTwitter;
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pgControl;
    MBProgressHUD *HUD;
}

- (IBAction)Signup_Click:(id)sender;

- (IBAction)Login_Click:(id)sender;

- (IBAction)FacebookLogin_Click:(id)sender;

- (IBAction)Twitter_Click:(id)sender;

@end
