//
//  EditProfileViewController.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 21/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileImageCaptureViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize lblLocation, lblBio, lblDisplayName, lblEmail, lblPhoto, lblPrivateInfo, lblPublicProfile, btnCancel, btnPassword, imgProfilePicture;
@synthesize navItem, scrollView, txtBioDescription, txtDisplayName, txtEmail, txtLocationName;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    txtBioDescription.delegate = self;
    txtDisplayName.delegate = self;
    txtEmail.delegate = self;
    txtLocationName.delegate = self;
    [self viewInitialization];
}

- (void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake([HelperMethod GetDeviceWidth], 720);
    [scrollView scrollRectToVisible:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:YES];
     [scrollView setFrame:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

- (void)viewInitialization {
    [imgProfilePicture setImage:[UIImage imageNamed:@"Profile_1"]];
    imgProfilePicture.layer.masksToBounds = YES;
    imgProfilePicture.userInteractionEnabled = YES;
    imgProfilePicture.layer.cornerRadius = 53.0f;
    imgProfilePicture.layer.borderWidth = 1.0f;
    lblPublicProfile.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_PublicProfile"];
    lblPhoto.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_Photo"];
    lblDisplayName.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_DisplayName"];
    txtDisplayName.placeholder = [HelperMethod GetLocalizeTextForKey:@"EditProfile_placeholder_DisplayName"];
    lblLocation.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_Location"];
    txtLocationName.placeholder = [HelperMethod GetLocalizeTextForKey:@"EditProfile_placeholder_Location"];
    lblBio.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_Bio"];
    txtBioDescription.placeholder = [HelperMethod GetLocalizeTextForKey:@"EditProfile_placeholder_BioDescription"];
    lblPrivateInfo.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_PrivateInfo"];
    lblEmail.text = [HelperMethod GetLocalizeTextForKey:@"EditProfile_lbl_Email"];
    txtEmail.placeholder = [HelperMethod GetLocalizeTextForKey:@"EditProfile_placeholder_Email"];
    [btnPassword setTitle:[HelperMethod GetLocalizeTextForKey:@"EditProfile_btn_Password"] forState:UIControlStateNormal];
    [btnPassword setTitle:[HelperMethod GetLocalizeTextForKey:@"EditProfile_btn_Password"] forState:UIControlStateSelected];
    [btnPassword setTitle:[HelperMethod GetLocalizeTextForKey:@"EditProfile_btn_Password"] forState:UIControlStateHighlighted];
    
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MovetoEditpicture:)];
    tapGeature.cancelsTouchesInView = YES;
    [self.imgProfilePicture addGestureRecognizer:tapGeature];

}

-(void)MovetoEditpicture:(UIGestureRecognizer *)gesture {
    ProfileImageCaptureViewController *profilePicture = (ProfileImageCaptureViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileImageCaptureViewController"];
    profilePicture.profilePictureDelegate = self;
    [self.navigationController pushViewController:profilePicture animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancel_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPassword_Click:(id)sender {
}

- (void)profilePictureCapturedSuccessfully:(UIImage *)profileImage {
    imgProfilePicture.image = profileImage;

}

@end
