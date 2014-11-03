//
//  SelectFilterViewController.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 13/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterSelectionDelegate <NSObject>

@optional
- (void)sizeSelectionCompleted:(NSMutableArray *)selectedSizeList;
- (void)brandSelectionCompleted:(NSMutableArray *)selectedBrandList;
- (void)categorySelectionCompleted:(NSMutableArray *)selectedCategoryList;

@end

@interface SelectFilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,MBProgressHUDDelegate,ApiRequestDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic, assign) id <FilterSelectionDelegate> sizeDelegate;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

@property (weak, nonatomic) IBOutlet UILabel *lblHeaderText;

@property (weak, nonatomic) IBOutlet UIView *vwHeader;

@property (weak, nonatomic) IBOutlet UIImageView *scrollImage;

@property (weak, nonatomic) IBOutlet UIButton *btnCategory;

@property (weak, nonatomic) IBOutlet UIButton *btnSize;

@property (weak, nonatomic) IBOutlet UIButton *btnBrand;

@property (weak, nonatomic) IBOutlet UIView *vwCategory;

@property (weak, nonatomic) IBOutlet UITableView *tblCategory;

@property (weak, nonatomic) IBOutlet UICollectionView *vwSizeCollection;

@property (weak, nonatomic) IBOutlet UIView *vwBrand;

@property (weak, nonatomic) IBOutlet UITableView *tblBrand;

@property (nonatomic, retain) NSMutableArray *selectedCategoryList;

@property (nonatomic, retain) NSMutableArray *selectedSizeList;

@property (nonatomic, retain) NSMutableArray *selectedBrandList;

- (IBAction)btnCancel_Click:(id)sender;

- (IBAction)btnSave_Click:(id)sender;

- (IBAction)SegmentChanged_Click:(id)sender;

@end
