//
//  ItemDetailsViewController.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/8/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailsViewController : UIViewController<MBProgressHUDDelegate, ApiRequestDelegate,UIScrollViewDelegate, UIDocumentInteractionControllerDelegate> {
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIView *vwHeader;

@property (weak, nonatomic) IBOutlet UIView *vwFooter;

@property (weak, nonatomic) IBOutlet UIImageView *scrollImage;

@property (weak, nonatomic) IBOutlet UIButton *btnPhotos;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@property (weak, nonatomic) IBOutlet UIButton *btnDetails;

@property (weak, nonatomic) IBOutlet UIButton *btnAddtocart;

@property (weak, nonatomic) IBOutlet UILabel *lblOriginalPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblSellingPrice;

@property (weak, nonatomic) IBOutlet UIView *vwUserDetails;

@property (weak, nonatomic) IBOutlet UIView *vwItemDetails;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pgImgesIndicator;

@property (weak, nonatomic) IBOutlet UIView *vwDetails;

@property (weak, nonatomic) IBOutlet UIView *vwShare;

@property (weak, nonatomic) IBOutlet UIButton *btnShareOnSocial;

@property (weak, nonatomic) IBOutlet UIScrollView *HorizontalScrollview;

@property (weak, nonatomic) IBOutlet UIImageView *imgUserImage;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UILabel *lblItemname;

@property (weak, nonatomic) IBOutlet UILabel *lblSize;

@property (weak, nonatomic) IBOutlet UILabel *lblGender;

@property (weak, nonatomic) IBOutlet UIView *vwPhotos;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeConstant;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (weak, nonatomic) IBOutlet UIButton *btnShareInstagram;

@property (weak, nonatomic) IBOutlet UILabel *lblBrand;

@property (weak, nonatomic) IBOutlet UILabel *lblBrandName;

@property (weak, nonatomic) IBOutlet UILabel *lblGenderDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblGenderName;

@property (weak, nonatomic) IBOutlet UILabel *lblSizeDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblSizeName;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblItemDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UILabel *lblLocationName;

@property (weak, nonatomic) IBOutlet UILabel *lblCondition;

@property (weak, nonatomic) IBOutlet UILabel *lblConditionValue;

@property (weak, nonatomic) IBOutlet UILabel *lblShipping;

@property (weak, nonatomic) IBOutlet UILabel *lblShippingPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblInstructionHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblInstruction;

@property (nonatomic, retain) UIDocumentInteractionController *dic;

- (IBAction)Back_CLick:(id)sender;

- (IBAction)AddCart_Click:(id)sender;

- (IBAction)SegmentChange_Click:(id)sender;

- (IBAction)Share_Click:(id)sender;

- (IBAction)btnShareInstagram_click:(id)sender;

@end
