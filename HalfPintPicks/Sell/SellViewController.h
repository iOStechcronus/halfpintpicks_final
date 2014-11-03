//
//  SellViewController.h
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIButton *btnWhiteSloves;
- (IBAction)WHITEGLOW_Click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnNormalShipping;
- (IBAction)LISTYOURSELF_Click:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *PgControls;

@end
