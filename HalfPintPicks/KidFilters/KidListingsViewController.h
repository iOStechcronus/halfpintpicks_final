//
//  KidListingsViewController.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KidViewCell.h"

@interface KidListingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ApiRequestDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITableView *tblKidlistings;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)Pushbackbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@end
