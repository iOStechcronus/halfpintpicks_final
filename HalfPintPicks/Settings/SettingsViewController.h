//
//  SettingsViewController.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 18/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UITableView *tblSettings;

- (IBAction)btnCancel_Click:(id)sender;

@end
