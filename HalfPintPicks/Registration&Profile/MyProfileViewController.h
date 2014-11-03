//
//  MyProfileViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetails.h"

@interface MyProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,ApiRequestDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UITableView *tblMyprofileData;

@property (strong, nonatomic) IBOutlet UIView *vwProfileDetails;

@property (strong, nonatomic) IBOutlet UIImageView *imgCoverPhoto;

@property (strong, nonatomic) IBOutlet UIImageView *imgProfilePhoto;

@property (strong, nonatomic) IBOutlet UIButton *btnFollow;

@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblLocation;

@property (strong, nonatomic) IBOutlet UILabel *lblChildName;

@property (strong, nonatomic) IBOutlet UIImageView *imgChildImage;

@property (strong, nonatomic) IBOutlet UIButton *btnAddKid;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UIImageView *ScrollImage;

@property (strong, nonatomic) IBOutlet UIButton *btnFirst;

@property (strong, nonatomic) IBOutlet UIButton *btnSecond;

@property (strong, nonatomic) IBOutlet UIButton *btnThird;

@property (strong, nonatomic) IBOutlet UITableView *tblFollowers;

- (IBAction)Follow_Click:(id)sender;

- (IBAction)Addkid_click:(id)sender;

- (IBAction)Segment_Click:(id)sender;

- (IBAction)btnSettings_Click:(id)sender;


@end
