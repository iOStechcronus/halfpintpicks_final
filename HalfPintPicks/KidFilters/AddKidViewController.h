//
//  AddKidViewController.h
//  HalfPintPicks
//
//  Created by TechCronus on 07/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageCaptureViewController.h"

@interface AddKidViewController : UIViewController<MBProgressHUDDelegate,ApiRequestDelegate,UITextFieldDelegate,ProfilePictureDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;
- (IBAction)Back_Click:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *txtKidFirstname;
@property (strong, nonatomic) IBOutlet UITextField *txtKidAge;
@property (strong, nonatomic) IBOutlet UITextField *txtKidShoeSize;
@property (strong, nonatomic) IBOutlet UITextField *txtKidClothSize;
@property (strong, nonatomic) IBOutlet UIButton *btnSaveandaddanother;
@property (strong, nonatomic) IBOutlet UIButton *btnSaveandfinish;
- (IBAction)Saveandfinish_click:(id)sender;
- (IBAction)Saveandaddanother_click:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblStatictext;
@property (strong, nonatomic) IBOutlet UIImageView *imgCover;
@property (strong, nonatomic) IBOutlet UILabel *lblKidname;
@property (strong, nonatomic) IBOutlet UIImageView *imgKidImage;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
