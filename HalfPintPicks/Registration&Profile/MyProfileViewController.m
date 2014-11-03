//
//  MyProfileViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "MyProfileViewController.h"
#import "AddKidViewController.h"
#import "UserDetails.h"
#import "SettingsViewController.h"
#import "KidListingsViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController {
    NSMutableArray *arrItemData;
    NSMutableArray *arrFollowersData;
    NSMutableArray *arrFollowingData;
    ItemListViewController *itemListViewController;
    int selectedIndex;
    BOOL iSSecondSegment;
    UISegmentedControl *segmentedControl;
}

@synthesize btnSecond,btnThird,btnFirst,btnAddKid,btnFollow,lblChildName,lblLocation,lblName,tblMyprofileData,imgChildImage,imgCoverPhoto,imgProfilePhoto,ScrollImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GeneralDeclaration generalDeclaration].currentScreen = @"MyProfileViewController";
    //[self Intilization];
    [self StaticData];
    [self SetUIApperence];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [GeneralDeclaration generalDeclaration].currentScreen = @"MyProfileViewController";
}

//This is just static method to load static data for testing
- (void)StaticData {
    ItemDetails *itemInfo = [[ItemDetails alloc]init];
    itemInfo.TotalUserItemCommentCount = 123;
    itemInfo.TotalUserItemLikeCount = 1244;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair ";
    itemInfo.ItemPrice = [@"780" intValue];
    arrItemData = [[NSMutableArray alloc]init];
    [arrItemData addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"111" intValue];
    itemInfo.TotalUserItemCommentCount = 111;
    itemInfo.TotalUserItemLikeCount = 222;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair 2 ";
    [arrItemData addObject:itemInfo];
    [arrItemData addObject:itemInfo];
    
    [imgChildImage setImage:[UIImage imageNamed:@"Kid"]];
    [imgCoverPhoto setImage:[UIImage imageNamed:@"cover_2"]];
    [imgProfilePhoto setImage:[UIImage imageNamed:@"Profile_1"]];
    
    arrFollowersData = [[NSMutableArray alloc]init];
    UserDetails *userInfo = [[UserDetails alloc]init];
    userInfo.ProfileImageName = @"";
    userInfo.FirstName = @"Vandan";
    userInfo.LastName = @"Javiya";
    [arrFollowersData addObject:userInfo];
    
    userInfo = [[UserDetails alloc]init];
    userInfo.ProfileImageName = @"";
    userInfo.FirstName = @"Hardik";
    userInfo.LastName = @"Shah";
    [arrFollowersData addObject:userInfo];
    
    userInfo = [[UserDetails alloc]init];
    userInfo.ProfileImageName = @"";
    userInfo.FirstName = @"Ketul";
    userInfo.LastName = @"Sheth";
    [arrFollowersData addObject:userInfo];
    
    userInfo = [[UserDetails alloc]init];
    userInfo.ProfileImageName = @"";
    userInfo.FirstName = @"Salin";
    userInfo.LastName = @"Shah";
    [arrFollowersData addObject:userInfo];
    
    userInfo = [[UserDetails alloc]init];
    userInfo.ProfileImageName = @"";
    userInfo.FirstName = @"Avish";
    userInfo.LastName = @"Shah";
    [arrFollowersData addObject:userInfo];
    
    arrFollowingData = [[NSMutableArray alloc]init];
    UserDetails *userFollowingInfo = [[UserDetails alloc]init];
    userFollowingInfo.ProfileImageName = @"";
    userFollowingInfo.FirstName = @"VD";
    userFollowingInfo.LastName = @"PATEL";
    [arrFollowingData addObject:userFollowingInfo];
    
    userFollowingInfo = [[UserDetails alloc]init];
    userFollowingInfo.ProfileImageName = @"";
    userFollowingInfo.FirstName = @"Hardik";
    userFollowingInfo.LastName = @"PATEL";
    [arrFollowingData addObject:userFollowingInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Intial method to set all UI related changes at intial level
- (void)SetUIApperence {
    self.btnFirst.backgroundColor = [UIColor clearColor];
    self.btnSecond.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    self.btnThird.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ScrollImage.frame = CGRectMake(0, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
    
    [btnAddKid setTitle:@"+\nKid" forState:UIControlStateNormal];
    btnAddKid.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnAddKid.layer.cornerRadius = 15.0f;
    btnAddKid.layer.borderWidth = 1.0f;
    btnAddKid.layer.borderColor = [UIColor whiteColor].CGColor;
    btnAddKid.titleLabel.numberOfLines = 2;
    [btnAddKid.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    
    
    imgChildImage.layer.borderWidth = 1.0f;
    imgChildImage.layer.borderColor = [UIColor whiteColor].CGColor;
    imgChildImage.layer.cornerRadius = 15.0f;
    imgChildImage.layer.masksToBounds =YES;
    imgChildImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MoveToKidListings)];
    tapGeature.cancelsTouchesInView = NO;
    [imgChildImage addGestureRecognizer:tapGeature];
    
    imgProfilePhoto.layer.masksToBounds =YES;
    imgProfilePhoto.layer.cornerRadius = 35.0;
    imgProfilePhoto.layer.borderWidth = 1.0f;
    imgProfilePhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [btnFirst setTitle:@"9 Listings" forState:UIControlStateNormal];
    [btnSecond setTitle:@"102 Followers" forState:UIControlStateNormal];
    [btnThird setTitle:@"111 Following" forState:UIControlStateNormal];
    selectedIndex = FirstIndex;
    [self.tblMyprofileData setHidden:NO];
    [self.tblFollowers setHidden:YES];
    [self.tblMyprofileData reloadData];
    btnAddKid.userInteractionEnabled = YES;
    
    [btnFollow setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    if(selectedIndex == FirstIndex)
    {
        self.btnFirst.backgroundColor = [UIColor clearColor];
        self.btnSecond.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        self.btnThird.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        ScrollImage.frame = CGRectMake(0, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
    }
    else if (selectedIndex == SecondIndex)
    {
        self.btnSecond.backgroundColor = [UIColor clearColor];
        self.btnFirst.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        self.btnThird.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        ScrollImage.frame = CGRectMake(107, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
    }
    else
    {
        self.btnThird.backgroundColor = [UIColor clearColor];
        self.btnSecond.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        self.btnFirst.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        ScrollImage.frame = CGRectMake(214, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
        
    }
}

//Method to Intilization of intial variables and methods
- (void)Intilization {
    // Segmented control with more customization and indexChangeBlock
//    
//    for(UIView *view in self.vwProfileDetails.subviews)
//    {
//        if([view isKindOfClass:[HMSegmentedControl class]])
//        {
//            [view removeFromSuperview];
//        }
//    }
//    HMSegmentedControl *segmentedControl3 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Three", @"4", @"Five"]];
//    [segmentedControl3 setFrame:CGRectMake(0, self.vwProfileDetails.frame.size.height - 30, [HelperMethod GetDeviceWidth], 30)];
//    [segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
//        //int indexTopass = (int)index;
//        //[self Changeeventchange:indexTopass];
//    }];
//    //segmentedControl3.selectionIndicatorHeight = 4.0f;
//    segmentedControl3.backgroundColor = [UIColor lightGrayColor];
//    segmentedControl3.textColor = [UIColor whiteColor];
//    segmentedControl3.selectedTextColor = [UIColor whiteColor];
//    segmentedControl3.selectionIndicatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];//[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1];
//    segmentedControl3.selectionStyle = HMSegmentedControlSelectionStyleBox;
//    //segmentedControl3.selectedSegmentIndex = HMSegmentedControlNoSegment;
//    segmentedControl3.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    segmentedControl3.shouldAnimateUserSelection = NO;
//    segmentedControl3.tag = 12;
    
    //[self.vwProfileDetails addSubview:segmentedControl3];
    
    //    NSArray *segmentTextContent = @[@"First",@"Second",@"Third"];
    //    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    //
    //    segmentedControl.frame = CGRectMake(0, self.vwProfileDetails.frame.size.height - 28, [HelperMethod GetDeviceWidth], 28);
    //
    //    [segmentedControl addTarget:self
    //                         action:@selector(segmentAction:)
    //               forControlEvents:UIControlEventValueChanged];
    //
    //    //segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //    segmentedControl.selectedSegmentIndex = 1;
    //    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    //
    //    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"1"]
    //                                forState:UIControlStateNormal
    //                              barMetrics:UIBarMetricsDefault];
    //
    //    [segmentedControl setDividerImage:[UIImage imageNamed:@"divider"]
    //                  forLeftSegmentState:UIControlStateNormal
    //                    rightSegmentState:UIControlStateNormal
    //                           barMetrics:UIBarMetricsDefault];
    //
    //
    //    /* Unselected background */
    //    UIImage *unselectedBackgroundImage = [[UIImage imageNamed:@"3"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    //    [[UISegmentedControl appearance] setBackgroundImage:unselectedBackgroundImage
    //                                               forState:UIControlStateNormal
    //                                             barMetrics:UIBarMetricsDefault];
    //
    //    /* Selected background */
    //    UIImage *selectedBackgroundImage = [[UIImage imageNamed:@"1"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    //    [[UISegmentedControl appearance] setBackgroundImage:selectedBackgroundImage
    //                                               forState:UIControlStateSelected
    //                                             barMetrics:UIBarMetricsDefault];
    //    [segmentedControl setTintColor:[UIColor whiteColor]];
    
    /* Image between two unselected segments */
    //    UIImage *bothUnselectedImage = [[UIImage imageNamed:@"bg_uns_uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    //    [[UISegmentedControl appearance] setDividerImage:bothUnselectedImage
    //                                 forLeftSegmentState:UIControlStateNormal
    //                                   rightSegmentState:UIControlStateNormal
    //                                          barMetrics:UIBarMetricsDefault];
    
    /* Image between segment selected on the left and unselected on the right */
    //    UIImage *leftSelectedImage = [[UIImage imageNamed:@"bg_sel_uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    //    [[UISegmentedControl appearance] setDividerImage:leftSelectedImage
    //                                 forLeftSegmentState:UIControlStateSelected
    //                                   rightSegmentState:UIControlStateNormal
    //                                          barMetrics:UIBarMetricsDefault];
    
    /* Image between segment selected on the right and unselected on the left */
    //    UIImage *rightSelectedImage = [[UIImage imageNamed:@"bg_uns_sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    //    [[UISegmentedControl appearance] setDividerImage:rightSelectedImage
    //                                 forLeftSegmentState:UIControlStateNormal
    //                                   rightSegmentState:UIControlStateSelected
    //                                          barMetrics:UIBarMetricsDefault];
    
    
    // we want attributed strings for this segmented control
    //    NSDictionary *textAttributes = @{ UITextAttributeTextColor:[UIColor whiteColor],
    //                                      UITextAttributeFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13] };
    //    [segmentedControl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    //
    //    textAttributes = @{ UITextAttributeTextColor:[UIColor whiteColor],
    //                        UITextAttributeFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13] };
    //    [segmentedControl setTitleTextAttributes:textAttributes forState:UIControlStateHighlighted];
    
    //[self.vwProfileDetails addSubview:segmentedControl];
//    ((SDSegmentedControl *)segmentControl).arrowHeightFactor *= -1.0;
//    ((SDSegmentedControl *)segmentControl).arrowSize *= 1;
//    ((SDSegmentedControl *)segmentControl).backgroundColor = [UIColor lightGrayColor];
//    self.segmentControl.hidden = YES;
//    //((SDSegmentedControl *)segmentControl).frame = CGRectMake(0, self.segmentControl.frame.origin.y - 20, self.segmentControl.frame.size.width, self.segmentControl.frame.size.height + 10);
//    SDSegmentView *segmenteViewAppearance = SDSegmentView.appearance;
//    [segmenteViewAppearance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [segmenteViewAppearance setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    segmenteViewAppearance.titleLabel.textAlignment = NSTextAlignmentCenter;
//    segmenteViewAppearance.frame = CGRectMake(0, segmenteViewAppearance.frame.origin.y, segmenteViewAppearance.frame.size.width + 80, segmenteViewAppearance.frame.size.height + 10);
//    SDStainView *stainViewAppearance = SDStainView.appearance;
//    [stainViewAppearance setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]] ];
//    segmenteViewAppearance.selectedTitleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
//    SDSegmentedControl *segmentedControlAppearance = SDSegmentedControl.appearance;
//    [stainViewAppearance setFrame:CGRectMake(0, 0, 100, segmentedControlAppearance.frame.size.height)];
    
}

//Target for moving user to Kid listing screens for current user
-(void)MoveToKidListings {
    KidListingsViewController *kidListVC = (KidListingsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"KidListingsViewController"];
    [self.navigationController pushViewController:kidListVC animated:YES];
    
}

#pragma Requests
//FirstRequest to get all approved Items list for current user
- (void)GetApprovedItemList {
    
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:FirstRequest];
}

//SecondRequest to get All pending Items list for current user
- (void)GetPendingItemList {
    
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:SecondRequest];
}

//ThirdRequest to get all followers list for current logged in user
- (void)GetFollowersList {
    
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:ThirdRequest];
}

//ForthRequest to get all following list of user for current logged in user
- (void)GetFollowingList {
    
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:ForthRequest];
}

#pragma ChangeSegment
- (void)Changeeventchange:(id)sender {
    
    UISegmentedControl *sgmt = (UISegmentedControl *)sender ;
    if(sgmt.selectedSegmentIndex == 0)
    {
        //[self GetApprovedItemList];
        iSSecondSegment = NO;
        [self StaticData];
        [self.tblMyprofileData reloadData];
    }
    else
    {
        //[self GetPendingItemList];
        [self StaticData];
        [arrItemData removeObjectAtIndex:2];
        iSSecondSegment = YES;
        [arrItemData removeObjectAtIndex:1];
        [self.tblMyprofileData reloadData];
    }
    NSLog(@"Selected index %ld (via block)", (long)sgmt.selectedSegmentIndex);
    
}

//To display loading view
- (void)displayLoadingView {
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
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
    
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"ALERT_WEBSERVICE_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];;
    [errorAlertView show];

}

- (void)apiRequestCompletedWithData:(NSMutableData *)responseData requestId:(int)requestId {
    
    NSError *error = nil;
    NSDictionary* responceDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options:kNilOptions
                                                                         error:&error];
    NSLog(@"%@",responceDictionary);
    [self dismissLoadingView];
    NSLog(@"%d",requestId);
    
    if([[responceDictionary valueForKey:@"status"] intValue] == Success)
    {
        if(requestId == FirstRequest)
        {
            [self.tblMyprofileData reloadData];
            
        }
        else if(requestId == SecondRequest)
        {
            [self.tblMyprofileData reloadData];
        }
        else if(requestId == ThirdRequest)
        {
            [self.tblFollowers reloadData];
        }
        else
        {
            [self.tblFollowers reloadData];
        }
    }
    else if([[responceDictionary valueForKey:@"status"] intValue] == Fail)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:[[NSBundle mainBundle] valueForKey:@"CFBundleName"] message:@"There is some error occured . Please check." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlert show];
    }
    
}

#pragma Tableview Delagate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(selectedIndex == FirstIndex)
        return 235.0f;
    else if(selectedIndex == SecondIndex)
        return 60.0f;
    else
        return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(selectedIndex == FirstIndex)
    {
        return ([arrItemData count]  / 2) + ([arrItemData count] % 2);
    }
    else if(selectedIndex == SecondIndex)
        return [arrFollowersData count];
    else if(selectedIndex == ThirdIdex)
        return [arrFollowingData count];
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == self.tblMyprofileData)
    {
        return 50;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vwHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth] , 50)];
    vwHeader.backgroundColor = [UIColor whiteColor];
    
    NSArray *segmentTextContent = @[@"7 Open",@"2 Pending"];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    
    segmentedControl.frame = CGRectMake(60, 10, [HelperMethod GetDeviceWidth] - 120, 29);
    [segmentedControl setTintColor:[UIColor lightGrayColor]];
    [segmentedControl addTarget:self
                             action:@selector(Changeeventchange:)
                   forControlEvents:UIControlEventValueChanged];
    
    //[segmentedControl setTitle:@"7 Open" forSegmentAtIndex:0];
    if(!iSSecondSegment)
        segmentedControl.selectedSegmentIndex = 0;
    else
        segmentedControl.selectedSegmentIndex = 1;  
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [vwHeader addSubview:segmentedControl];
    return vwHeader;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.tblMyprofileData])
    {
       static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
        }
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
        ItemDetails *itemInfo = (ItemDetails *) [arrItemData objectAtIndex:(indexPath.row ) * 2];
        itemListViewController = (ItemListViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ItemListViewController"];
        itemListViewController.itemInfo = itemInfo;
        itemListViewController.view.tag = (indexPath.row) * 2;
        itemListViewController.view.frame = CGRectMake(8, 9, 150, 225);
        [cell addSubview:itemListViewController.view];
        
        if((((indexPath.row) * 2) + 1) < [arrItemData count])
            itemInfo = (ItemDetails *) [arrItemData objectAtIndex:(((indexPath.row) * 2) + 1)];
        else
            itemInfo = nil;
        
        if(itemInfo != nil)
        {
            itemListViewController = (ItemListViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ItemListViewController"];
            itemListViewController.itemInfo = itemInfo;
            itemListViewController.view.frame = CGRectMake(164, 9, 150, 225);
            itemListViewController.view.tag = ((indexPath.row) * 2) + 1;
            [cell addSubview:itemListViewController.view];
        }
        
        return cell;
    }
    else if([tableView isEqual:self.tblFollowers])
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            cell.userInteractionEnabled = YES;
            EGOImageView *userProfileimg = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Userprofile.png"]];
            userProfileimg.frame = CGRectMake(10, 10, 40, 40);
            userProfileimg.layer.masksToBounds = YES;
            userProfileimg.layer.cornerRadius = 20.0;
            userProfileimg.layer.borderColor = [[UIColor blackColor] CGColor];
            userProfileimg.tag = 110;
            [cell addSubview:userProfileimg];
            
            UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 40)];
            userName.tag = 117;
            userName.textAlignment = NSTextAlignmentLeft;
            userName.textColor = [UIColor lightGrayColor];
            userName.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];;
            [cell addSubview:userName];
        }
        
        
        EGOImageView *userProfileimg = (EGOImageView *)[cell viewWithTag:110];
        UILabel *lblUsername = (UILabel*) [cell viewWithTag:117];
        
        if(selectedIndex == SecondIndex)
        {
            UserDetails *info = [arrFollowersData objectAtIndex:indexPath.row];
            if (![info.ProfileImageName isEqualToString:@""]) {
                NSString *imageURL =  info.ProfileImageName;
                imageURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [userProfileimg setImageURL:[NSURL URLWithString:imageURL]];
            }
            else
                [userProfileimg setImage:[UIImage imageNamed:@"Profile_1"]];
            
            [lblUsername setText:[NSString stringWithFormat:@"%@ %@",info.FirstName,info.LastName]];
        }
        else if(selectedIndex == ThirdIdex)
        {
            UserDetails *info = [arrFollowingData objectAtIndex:indexPath.row];
           
            if (![info.ProfileImageName isEqualToString:@""]) {
                NSString *imageURL =  info.ProfileImageName;
                imageURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [userProfileimg setImageURL:[NSURL URLWithString:imageURL]];
            }
            else
                [userProfileimg setImage:[UIImage imageNamed:@"Profile_1"]];
            
            [lblUsername setText:[NSString stringWithFormat:@"%@ %@",info.FirstName,info.LastName]];
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        return cell;
    }
    
}

- (IBAction)Follow_Click:(id)sender {
}

//Add kid button click events
- (IBAction)Addkid_click:(id)sender {
    
    AddKidViewController *addKidVC = (AddKidViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddKidViewController"];
    [self.navigationController pushViewController:addKidVC animated:YES];
    
}

//Segment change events
- (IBAction)Segment_Click:(id)sender {
    UIButton *btnSelected = (UIButton *)sender;
    if(btnSelected.tag == 15)
    {
        selectedIndex = FirstIndex;
        self.tblMyprofileData.hidden = NO;
        self.tblFollowers.hidden = YES;
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            ScrollImage.frame = CGRectMake(0, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
            self.btnFirst.backgroundColor = [UIColor clearColor];
            self.btnSecond.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            self.btnThird.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];
        [self.tblMyprofileData reloadData];
        //[self GetApprovedItemList];
    }
    else if (btnSelected.tag == 16)
    {
        selectedIndex = SecondIndex;
        
        self.tblMyprofileData.hidden = YES;
        self.tblFollowers.hidden = NO;
        
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            ScrollImage.frame = CGRectMake(107, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
            self.btnSecond.backgroundColor = [UIColor clearColor];
            self.btnFirst.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            self.btnThird.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];
        [self.tblFollowers reloadData];
        //[self GetFollowersList];
    }
    else
    {
        selectedIndex = ThirdIdex;
        
        self.tblMyprofileData.hidden = YES;
        self.tblFollowers.hidden = NO;
        
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            ScrollImage.frame = CGRectMake(214, 0, self.ScrollImage.frame.size.width, self.ScrollImage.frame.size.height);
            self.btnThird.backgroundColor = [UIColor clearColor];
            self.btnFirst.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            self.btnSecond.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];
         [self.tblFollowers reloadData];
        //[self GetFollowingList];
    }
    
}

//Settings button click to load all settings
- (IBAction)btnSettings_Click:(id)sender {
    SettingsViewController *settingsViewController = (SettingsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    navigationController.navigationBarHidden = YES;
    settingsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end
