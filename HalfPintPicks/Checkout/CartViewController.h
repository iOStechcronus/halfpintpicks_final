//
//  CartViewController.h
//  HalfPintPicks
//
//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewCell.h"

@interface CartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ApiRequestDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UIButton *btnCheckout;
- (IBAction)btnCheckout_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UIButton *btnShipping;
@property (strong, nonatomic) IBOutlet UIButton *btnPayment;
@property (weak, nonatomic) IBOutlet UIView *vwFooter;
@property (weak, nonatomic) IBOutlet UILabel *lblShippingPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (strong, nonatomic) IBOutlet UIImageView *selectionImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightConstant;
@property (weak, nonatomic) IBOutlet UITableView *tblCartDetails;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
