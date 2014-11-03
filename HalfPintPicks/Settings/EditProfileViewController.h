//
//  EditProfileViewController.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 21/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageCaptureViewController.h"

@interface EditProfileViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, MBProgressHUDDelegate,ProfilePictureDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lblPublicProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblPhoto;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *lblDisplayName;

@property (weak, nonatomic) IBOutlet UITextField *txtDisplayName;

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UITextField *txtLocationName;

@property (weak, nonatomic) IBOutlet UILabel *lblBio;

@property (weak, nonatomic) IBOutlet UITextField *txtBioDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblPrivateInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnPassword;

- (IBAction)btnCancel_Click:(id)sender;

- (IBAction)btnPassword_Click:(id)sender;

@end
