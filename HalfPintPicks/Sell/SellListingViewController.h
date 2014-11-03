//
//  SellListingViewController.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellListingViewController : UIViewController<ApiRequestDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollview;
@property (weak, nonatomic) IBOutlet UIScrollView *horizontalScrollview;
@property (weak, nonatomic) IBOutlet UILabel *lblGenderSelection;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UITableView *tblItemDetails;
@property (weak, nonatomic) IBOutlet UIView *vwGenderSelection;
@property (weak, nonatomic) IBOutlet UIView *vwItemCondition;
@property (weak, nonatomic) IBOutlet UIView *vwOriginalPrice;
@property (weak, nonatomic) IBOutlet UIView *vwSellingPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOriginalPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtOriginalPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtSellingPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSuggestedPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSellingPrice;
@property (weak, nonatomic) IBOutlet UIView *vwShipping;
@property (weak, nonatomic) IBOutlet UITextField *txtShippingPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblShippingPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalPrice;
@property (weak, nonatomic) IBOutlet UIView *vwTotalDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
- (IBAction)SellerPolicy_CLick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSellerDetails;
- (IBAction)Back_click:(id)sender;

@end
