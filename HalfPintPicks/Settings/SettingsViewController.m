//
//  SettingsViewController.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 18/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "SettingsViewController.h"
#import "EditProfileViewController.h"
#import "BillingInfoViewController.h"
#import "ShippingInfoViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController {
    NSMutableArray *settingsHeader;
    NSMutableArray *settingsData;
}

@synthesize navItem, btnCancel, tblSettings;

- (void)viewDidLoad {
    [super viewDidLoad];
    navItem.title = [HelperMethod GetLocalizeTextForKey:@"Settings_Title"];
    navItem.rightBarButtonItem.title = @"Cancel";
    tblSettings.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.hidesBottomBarWhenPushed = YES;
    [self viewInitialization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewInitialization {
    NSMutableArray *accountArray = [[NSMutableArray alloc] initWithObjects:[HelperMethod GetLocalizeTextForKey:@"Settings_lbl_EditProfile"],
                                                                           [HelperMethod GetLocalizeTextForKey:@"Settings_lbl_BillingInfo"],
                                                                           [HelperMethod GetLocalizeTextForKey:@"Settings_lbl_ShippingInfo"],
                                                                           [HelperMethod GetLocalizeTextForKey:@"Settings_lbl_Payout"], nil];
    
    NSMutableArray *settingsArray = [[NSMutableArray alloc] initWithObjects:[HelperMethod GetLocalizeTextForKey:@"Settings_lbl_Notifications"],
                                                                            nil];
    
    NSMutableArray *logoutArray = [[NSMutableArray alloc] initWithObjects:[HelperMethod GetLocalizeTextForKey:@"Settings_lbl_Logout"], nil];
    
    settingsData = [[NSMutableArray alloc] initWithObjects:accountArray, settingsArray, logoutArray, nil];
    
    settingsHeader = [[NSMutableArray alloc] initWithObjects:[HelperMethod GetLocalizeTextForKey:@"Settings_Header_Account"],
                                                             [HelperMethod GetLocalizeTextForKey:@"Settings_Header_Settings"], nil];
}

- (IBAction)btnCancel_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Tableview Datasource and Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [settingsData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[settingsData objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    tableView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[settingsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        EditProfileViewController *editProfileViewController = (EditProfileViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
        [self.navigationController pushViewController:editProfileViewController animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
            BillingInfoViewController *billingInfoViewController = (BillingInfoViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"BillingInfoViewController"];
            [self.navigationController pushViewController:billingInfoViewController animated:YES];
        }

    else if (indexPath.section == 0 && indexPath.row == 2) {
        ShippingInfoViewController *shippingIngoVC = (ShippingInfoViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ShippingInfoViewController"];
        //[self.navigationController pushViewController:shippingIngoVC animated:YES];
        [self presentViewController:shippingIngoVC animated:YES completion:nil];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect labelFrame = CGRectMake(10, 10, 280, 15);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.textColor = [UIColor colorWithRed:32/255.0f green:32/255.0f blue:32/255.0f alpha:1.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Helvetica-Neue" size:18.0];
    if (section != 2)
        label.text = [settingsHeader objectAtIndex:section];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1.0f];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section >= 2)
//        return 160;
//    else
        return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

@end
