//
//  KidListingsViewController.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/23/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "KidListingsViewController.h"

@interface KidListingsViewController ()

@end

@implementation KidListingsViewController
{
    NSMutableArray *arrKiddata;
    int selectedRow;
    
}
@synthesize tblKidlistings,navBar,navItem,btnBack;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrKiddata = [[NSMutableArray alloc]init];
    [self StaticData];
    //[self GetKidListingForcurrentuser];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
       [tblKidlistings setFrame:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight] - 74)];

}

//This is just static method for creating static data for testing
- (void)StaticData {
    
    KidDetails *kidInfo = [[KidDetails alloc]init];
    kidInfo.ProfileImage = @"Kid.png";
    kidInfo.FullName = @"Vandan Javiya";
    kidInfo.Age = [@"10" intValue];
    kidInfo.ClothSize = @"6mo-12mo";
    kidInfo.ShoeSize = @"36XL";
    [arrKiddata addObject:kidInfo];
    [arrKiddata addObject:kidInfo];
    
    kidInfo = [[KidDetails alloc]init];
    kidInfo.ProfileImage = @"Kid.png";
    kidInfo.FullName = @"VD PATEL";
    kidInfo.Age = [@"12" intValue];
    kidInfo.ClothSize = @"6mo-12mo";
    kidInfo.ShoeSize = @"39XL";
    [arrKiddata addObject:kidInfo];
    [arrKiddata addObject:kidInfo];
    
    
    kidInfo = [[KidDetails alloc]init];
    kidInfo.ProfileImage = @"Kid.png";
    kidInfo.FullName = @"HJ SHAH";
    kidInfo.Age = [@"15" intValue];
    kidInfo.ClothSize = @"13mo-15mo";
    kidInfo.ShoeSize = @"37XL";
    [arrKiddata addObject:kidInfo];
    [arrKiddata addObject:kidInfo];
    
    kidInfo = [[KidDetails alloc]init];
    kidInfo.ProfileImage = @"Kid.png";
    kidInfo.FullName = @"Piyush H Shah";
    kidInfo.Age = [@"18" intValue];
    kidInfo.ClothSize = @"23mo-43mo";
    kidInfo.ShoeSize = @"S";
    [arrKiddata addObject:kidInfo];
    [arrKiddata addObject:kidInfo];
    
    kidInfo = [[KidDetails alloc]init];
    kidInfo.ProfileImage = @"Userprofile.png";
    kidInfo.FullName = @"Under Progress";
    kidInfo.Age = [@"1" intValue];
    kidInfo.ClothSize = @"1mo-2mo";
    kidInfo.ShoeSize = @"S";
    [arrKiddata addObject:kidInfo];

    [tblKidlistings reloadData];
}

#pragma Send Requests
//Web api request to get all kids for current loggedin users
-(void)GetKidListingForcurrentuser {
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:FirstRequest];
}

//Remove kid request for current user
//Parameters : KidId , ParentId
//Return : void

-(void)RemoveKidbyKidAndParentId:(int)kidId ParentId:(int)parentId {
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?kidid=%d&parentid=%d",kidId,parentId]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:SecondRequest];
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

#pragma WebRequests callback Delagate Methods
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
            arrKiddata = [[NSMutableArray alloc]init];
            arrKiddata = [JSONParser ParseKidsDataFromJsonData:[responceDictionary valueForKey:@"data"]];
            [tblKidlistings reloadData];
        }
        else
        {
            UIAlertView *erroralertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            erroralertView.tag = 2;
            [erroralertView show];
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

//Back button click event
- (IBAction)Pushbackbutton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//Remove kid method for remove button click
-(void)RemoveKid:(id)sender {
    UIButton *btnClose = (UIButton *)sender;
    selectedRow = btnClose.tag;
    UIAlertView *confirmationAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"ALERT_DELETECONFIRMATION_MESSAGE"] delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];;
    confirmationAlert.tag = 3;
    [confirmationAlert show];
    
}

#pragma Alertview Delagates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 3)
    {
        
        if(buttonIndex == 0)
        {
           
            NSLog(@"%d",selectedRow);
            //KidDetails *kidInfo = [arrKiddata objectAtIndex:selectedRow];
            //self RemoveKidbyKidAndParentId:kidInfo.KidId ParentId:kidInfo.ParentId];
        }
        else
        {
            
        }
    }
}

#pragma Tableview Datasource and Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrKiddata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"KidDetailsCell";
    KidViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
        cell = [[KidViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KidDetails *kidInfo = (KidDetails *)[arrKiddata objectAtIndex:indexPath.row];
    cell.imgKid.image = [UIImage imageNamed:kidInfo.ProfileImage];
    cell.lblShoesvalue.text = kidInfo.ShoeSize;
    cell.lblFullname.text = kidInfo.FullName;
    cell.lblAgevalue.text = [NSString stringWithFormat:@"%d Year(s)",kidInfo.Age];
    cell.lblClothvalue.text = kidInfo.ClothSize;
    cell.btnClose.tag = indexPath.row;
    [cell.btnClose addTarget:self action:@selector(RemoveKid:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

@end
