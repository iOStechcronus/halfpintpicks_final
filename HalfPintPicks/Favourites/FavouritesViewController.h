//
//  FavouritesViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFilterViewController.h"

@interface FavouritesViewController : UIViewController<ApiRequestDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,FilterSelectionDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
- (IBAction)Filters_Click:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@property (weak, nonatomic) IBOutlet UITableView *tblItemData;

@end
