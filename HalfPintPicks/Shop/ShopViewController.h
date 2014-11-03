//
//  ShopViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKMeme.h"
#import "AKLookups.h"
#import "AKLookupsListViewController.h"
#import "SelectFilterViewController.h"

@interface ShopViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, ApiRequestDelegate,AKLookupsDatasource, AKLookupsListDelegate, FilterSelectionDelegate> {
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *filterBarItem;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBox;

@property (strong, nonatomic) IBOutlet UITableView *tblShopData;

- (IBAction)btnFilter_Click:(id)sender;

@end
