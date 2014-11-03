//
//  SellListingViewController.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "SellListingViewController.h"
#import "SellListingViewController.h"

@interface SellListingViewController ()

@end

@implementation SellListingViewController
{
    NSMutableArray *arrBrands;
    NSMutableArray *arrCategories;
    NSMutableArray *arrSizes;
}
@synthesize txtOriginalPrice,txtSellingPrice,txtShippingPrice,txtTotalPrice,txtViewDescription,lblGenderSelection,lblOriginalPrice,lblSellingPrice,lblShippingPrice,lblSuggestedPrice,lblTotal,vwGenderSelection,vwItemCondition,vwOriginalPrice,vwSellingPrice,vwShipping,vwTotalDetails,btnPost,btnSellerDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    
    [self.mainScrollview setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], btnPost.frame.origin.y + 300)];
    [self SetUIApperence];
}

//Intial method to set all UI related changes at intial level
-(void)SetUIApperence {
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
    tapGeature.cancelsTouchesInView = YES;
    [self.mainScrollview addGestureRecognizer:tapGeature];
    vwOriginalPrice.layer.borderWidth = 2.0f;
    vwSellingPrice.layer.borderWidth = 2.0f;
    vwShipping.layer.borderWidth = 2.0f;
    vwTotalDetails.layer.borderWidth = 2.0f;
    txtViewDescription.layer.borderWidth = 2.0f;
    vwOriginalPrice.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor;
    vwShipping.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor;
    vwSellingPrice.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor;
    vwTotalDetails.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor;
    txtViewDescription.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor;
}

//Method to set scrollview position to intial conditions and end editing for textfields
- (void)RevertEditing {
    [self.view endEditing:YES];
//    [self.mainScrollview scrollRectToVisible:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];
    //[scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

//To display loading view
- (void)displayLoadingView {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    [HUD hide:YES afterDelay:30.0];
}

//To dismiss loading view
- (void)dismissLoadingView {
    [HUD removeFromSuperview];
    HUD = nil;
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [HUD removeFromSuperview];
    HUD = nil;
}

#pragma Requests callback Delagate Methods
- (void)apiRequestCompletedWithError:(NSString *)errorString requestId:(int)requestId{
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"ALERT_WEBSERVICE_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    errorAlertView.tag = 1;
    [errorAlertView show];
}

- (void)apiRequestCompletedWithData:(NSMutableData *)responseData requestId:(int)requestId {
    
    NSError *error = nil;
    //NSString *responceString = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",responceString);
    NSDictionary* responceDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options:kNilOptions
                                                                         error:&error];
    NSLog(@"%@",responceDictionary);
    [self dismissLoadingView];
    NSLog(@"%d",requestId);
    if(requestId == FirstRequest)
    {
        if([[responceDictionary valueForKey:@"status"] intValue] == Success)
        {
            arrCategories = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"categories"]];
            arrSizes = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"sizes"]];
            arrBrands = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"brands"]];

        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SellerPolicy_CLick:(id)sender {
}

#pragma TextField Methods
    

#pragma Tableview Datasource and Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"";
    if(indexPath.row == 0)
        CellIdentifier = @"CategoryCell" ;
    else if(indexPath.row == 1)
        CellIdentifier = @"SizeCell" ;
    else if(indexPath.row == 2)
        CellIdentifier = @"BrandCell" ;
    else
        CellIdentifier = @"ShippingCell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (IBAction)Back_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];  
}
@end
