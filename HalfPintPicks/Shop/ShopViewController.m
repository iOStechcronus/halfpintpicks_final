//
//  ShopViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "ShopViewController.h"
#import "AddKidViewController.h"
#import "ItemDetailsViewController.h"
#import "ItemListViewController.h"
#import "SelectFilterViewController.h"
#import "KidListingsViewController.h"

@interface ShopViewController () {
    NSArray *_items;
    UIImageView *_memeImageView;
    AKMeme *_selectedMeme;
    AKLookups *btnDropdown;
    BOOL _menuPresented;
    AKLookupsListViewController *_listVC;
    UIView *tappedView;
    SizeGroup *selectedSize;
}

@end

@implementation ShopViewController {
    NSMutableArray *arrShoppingData;
    ItemListViewController *itemListViewController;
}

@synthesize searchBox,tblShopData,navBar,navItem,filterBarItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self StaticData];
    _items = @[[AKMeme memeWithTitle:@"ALL" imageName:@""],
               [AKMeme memeWithTitle:@"FOLLOWING" imageName:@""],
               [AKMeme memeWithTitle:@"FEATURED"  imageName:@""]];
    [GeneralDeclaration generalDeclaration].currentScreen = @"ShopViewController";
    
    
    //
    btnDropdown = [[AKLookups alloc] initWithLookupViewController:self.listVC];
    btnDropdown.frame = CGRectMake(90.0f, 27.0f, 140.0f, 30.0f);
    [btnDropdown.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    [btnDropdown setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDropdown setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btnDropdown setBackgroundColor:[UIColor clearColor]];
    //Set Selected Item
    id<AKLookupsCapableItem> item = _items[0];
    [btnDropdown selectItem:item];
    [self.view addSubview:btnDropdown];
    // Do any additional setup after loading the view.
    
    
    /////Add kid Button to navigation bar
    UIButton *btnAddKid = [[UIButton alloc] initWithFrame: CGRectMake(10, 7, 30, 30)];
    [btnAddKid setTitle:@"+\nKid" forState:UIControlStateNormal];
    [btnAddKid setTitleColor:[UIColor colorWithRed:65.0f/255.0f green:70.0f/255.0f blue:77.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    btnAddKid.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btnAddKid.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnAddKid.layer.cornerRadius = 15.0f;
    btnAddKid.layer.borderWidth = 1.0f;
    btnAddKid.layer.borderColor = [UIColor colorWithRed:65.0f/255.0f green:70.0f/255.0f blue:77.0f/255.0f alpha:1.0f].CGColor;
    btnAddKid.titleLabel.numberOfLines = 2;
    [btnAddKid.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [btnAddKid addTarget:self action:@selector(Addkid_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addKidbarbutton = [[UIBarButtonItem alloc] initWithCustomView:btnAddKid] ;
    self.navItem.leftBarButtonItem = addKidbarbutton;
}

- (void)StaticData {
    ItemDetails *itemInfo = [[ItemDetails alloc]init];
    itemInfo.TotalUserItemCommentCount = 123;
    itemInfo.TotalUserItemLikeCount = 1244;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair ";
    itemInfo.ItemPrice = [@"780" intValue];
    arrShoppingData = [[NSMutableArray alloc]init];
    [arrShoppingData addObject:itemInfo];
    [arrShoppingData addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"111" intValue];
    itemInfo.TotalUserItemCommentCount = 111;
    itemInfo.TotalUserItemLikeCount = 222;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair 2 ";
    [arrShoppingData addObject:itemInfo];
    [arrShoppingData addObject:itemInfo];
    
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"2222" intValue];
    itemInfo.TotalUserItemCommentCount = 444;
    itemInfo.TotalUserItemLikeCount = 555;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair 4 on the way ";
    [arrShoppingData addObject:itemInfo];
    [arrShoppingData addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"111" intValue];
    itemInfo.TotalUserItemCommentCount = 343;
    itemInfo.TotalUserItemLikeCount = 654;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair 4 on the way ";
    [arrShoppingData addObject:itemInfo];
    [arrShoppingData addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"5555" intValue];
    itemInfo.TotalUserItemCommentCount = 333;
    itemInfo.TotalUserItemLikeCount = 4444;
    itemInfo.ItemFrontImage = @"";
    itemInfo.ItemName = @"Baby care whell chair 5 on the way ";
    [arrShoppingData addObject:itemInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma AddtoCart Events
- (void)AddtoCart:(id)sender {
    UIButton *cartButton = (UIButton *)sender;
    NSLog(@"%ld",(long)cartButton.tag);
}

#pragma Requests
//FirstRequest
- (void)GetAllAvailableItemsList {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
        [apirequest sendJsonGetRequestwithurl:urlString requestId:FirstRequest];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HelperMethod GetLocalizeTextForKey:@"Alert_Header"] message:[HelperMethod GetLocalizeTextForKey:@"Warning_NoInternet"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 0;
        [alert show];
    }
}

//SecondRequest
- (void)GetAllFollowingItemsList {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
        [apirequest sendJsonGetRequestwithurl:urlString requestId:SecondRequest];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HelperMethod GetLocalizeTextForKey:@"Alert_Header"] message:[HelperMethod GetLocalizeTextForKey:@"Warning_NoInternet"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 0;
        [alert show];
    }
}

//ThirdRequest
- (void)GetAllFeaturedItemsList {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
        [apirequest sendJsonGetRequestwithurl:urlString requestId:ThirdRequest];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HelperMethod GetLocalizeTextForKey:@"Alert_Header"] message:[HelperMethod GetLocalizeTextForKey:@"Warning_NoInternet"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 0;
        [alert show];
    }
}

//Forth
-(void)InsertItemLike:(ItemDetails *)itemInfo {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/GetInsertItemLike?ItemId=%d&userId=%d",1,2]];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [apirequest sendJsonGetRequestwithurl:urlString requestId:ForthRequest];
    }
    else
    {
        UIAlertView *internetError = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"INTERNETCONNECTION_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [internetError show];
        
    }
}

//Fifth
-(void)GetDisLikeItem:(ItemDetails *)itemInfo {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/GetDisLikeItem?ItemId=%d&userId=%d",1,2]];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [apirequest sendJsonGetRequestwithurl:urlString requestId:FifthRequest];
    }
    else
    {
        UIAlertView *internetError = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"INTERNETCONNECTION_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [internetError show];
    }
}

- (void)moveToDetails:(UITapGestureRecognizer *)gesture {
    tappedView = [gesture view];
    //ItemBoutique *itemInfo = (ItemBoutique * )[partyItemList objectAtIndex:tappedView.tag];
    ItemDetailsViewController *itemDetailsViewController = (ItemDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailsViewController"];
    //itemDetail.itemDetailsUpdateDelegate = self;
    //itemDetail.urlKey = itemInfo.ItemUrlKey;
    [self.navigationController pushViewController:itemDetailsViewController animated:YES];
}

-(void)LikeUnlike:(id)sender
{
    UIButton *btnLike = (UIButton *)sender;
    NSLog(@"%d",btnLike.tag);
    ItemDetails *itemInfo = (ItemDetails *)[arrShoppingData objectAtIndex:btnLike.tag];
    if(itemInfo.ItemLikeStatus)
    {
        itemInfo.ItemLikeStatus = NO;
        [arrShoppingData replaceObjectAtIndex:btnLike.tag withObject:itemInfo];
        [self GetDisLikeItem:itemInfo];
    }
    else
    {
        itemInfo.ItemLikeStatus = YES;
        [arrShoppingData replaceObjectAtIndex:btnLike.tag withObject:itemInfo];
        [self InsertItemLike:itemInfo];
        
    }
}

#pragma Requests callback Delagate Methods
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
        arrShoppingData = [[NSMutableArray alloc]init];
        arrShoppingData = [JSONParser ParseItemBoutiqueFromJsonData:[responceDictionary valueForKey:@"data"]];
        if(requestId == FirstRequest)
        {
            [self.tblShopData reloadData];
        }
        else if(requestId == SecondRequest)
        {
            [self.tblShopData reloadData];
        }
        else if(requestId == ThirdRequest)
        {
            [self.tblShopData reloadData];
        }
        else if (requestId == ForthRequest)
        {
            
        }
        else if (requestId == FifthRequest)
        {
            
        }
        
    }
    else
    {
        UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [registrationErrorView show];
    }
}

#pragma AddKid
- (void)Addkid_Click:(id)sender {
    AddKidViewController *addKidVC = (AddKidViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddKidViewController"];
    [self.navigationController pushViewController:addKidVC animated:YES];
    
//    KidListingsViewController *kidlistVC = (KidListingsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"KidListingsViewController"];
//    [self.navigationController pushViewController:kidlistVC animated:YES];
}

#pragma Search Button Delegate Methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma Tableview Delagate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 235.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([arrShoppingData count]  / 2) + ([arrShoppingData count] % 2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    }
    tableView.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    cell.userInteractionEnabled = YES;
    
    ItemDetails *itemInfo = (ItemDetails *) [arrShoppingData objectAtIndex:(indexPath.row ) * 2];
    itemListViewController = (ItemListViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ItemListViewController"];
    itemListViewController.itemInfo = itemInfo;
    itemListViewController.view.tag = (indexPath.row) * 2;
    itemListViewController.view.frame = CGRectMake(7, 9, 150, 225);
    itemListViewController.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToDetails:)];
    tapGesture.cancelsTouchesInView = YES;
    [itemListViewController.view addGestureRecognizer:tapGesture];
    
    
    UIButton *btnCart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCart.frame = CGRectMake(itemListViewController.view.frame.size.width - 40, 10, 30 , 30);
    [btnCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnCart.alpha = 0.5;
    [btnCart setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    btnCart.backgroundColor = [UIColor blackColor];
    btnCart.layer.cornerRadius = 5.0f;
    [btnCart addTarget:self action:@selector(AddtoCart:) forControlEvents:UIControlEventTouchUpInside];
    btnCart.userInteractionEnabled = YES;
    btnCart.tag = indexPath.row * 2;
    
    //Target to add like and unlike
    itemListViewController.btnLike.tag= indexPath.row;
    [itemListViewController.btnLike addTarget:self action:@selector(LikeUnlike:) forControlEvents:UIControlEventTouchUpInside];
    
    [itemListViewController.view addSubview:btnCart];
    [cell addSubview:itemListViewController.view];
    
    if((((indexPath.row) * 2) + 1) < [arrShoppingData count])
        itemInfo = (ItemDetails *) [arrShoppingData objectAtIndex:(((indexPath.row) * 2) + 1)];
    else
        itemInfo = nil;
    
    if(itemInfo != nil)
    {
        itemListViewController = (ItemListViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ItemListViewController"];
        itemListViewController.itemInfo = itemInfo;
        itemListViewController.view.frame = CGRectMake(164, 9, 150, 225);
        itemListViewController.view.tag = ((indexPath.row) * 2) + 1;
        
        itemListViewController.view.userInteractionEnabled = YES;
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToDetails:)];
        tapGesture.cancelsTouchesInView = YES;
        [itemListViewController.view addGestureRecognizer:tapGesture];
        
        btnCart = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCart.frame = CGRectMake(itemListViewController.view.frame.size.width - 40, 10, 30 , 30);
        [btnCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [btnCart setTitle:@"Cart" forState:UIControlStateNormal];
        [btnCart setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
        btnCart.backgroundColor = [UIColor blackColor];
        btnCart.layer.cornerRadius = 5.0f;
        btnCart.alpha = 0.5;
        [btnCart addTarget:self action:@selector(AddtoCart:) forControlEvents:UIControlEventTouchUpInside];
        btnCart.userInteractionEnabled = YES;
        btnCart.tag = ((indexPath.row) * 2) + 1;
        [itemListViewController.view addSubview:btnCart];
        [cell addSubview:itemListViewController.view];
    }
    
    return cell;
}



#pragma DropDown related Methods and Delegates
- (NSArray *)lookupsItems {
    return _items;
}

- (id<AKLookupsCapableItem>)lookupsSelectedItem {
    return _selectedMeme;
}

#pragma mark - Lookup delegate
- (void)lookups:(AKDropdownViewController *)lookups didSelectItem:(id<AKLookupsCapableItem>)item {
    [btnDropdown selectItem:item];
    [btnDropdown closeLookup];
    
    if([item isEqual:[_items objectAtIndex:0]]) {
        NSLog(@"One");
        //[self GetAllAvailableItemsList];
    }
    else if ([item isEqual:[_items objectAtIndex:1]]) {
        NSLog(@"Two");
        //[self GetAllFollowingItemsList];
    }
    else {
        NSLog(@"Three");
        //[self GetAllFeaturedItemsList];
    }
}

- (void)lookupsDidOpen:(AKDropdownViewController *)lookups {
    _menuPresented = YES;
}

- (void)lookupsDidClose:(AKDropdownViewController *)lookups {
    _menuPresented = NO;
}

- (void)lookupsDidCancel:(AKDropdownViewController *)lookups {
    [btnDropdown closeAnimation];
    _menuPresented = NO;
}

#pragma mark - Helpers
- (void)showMenu:(id)sender {
    if (!_menuPresented){
        [self.listVC showDropdownViewBelowView:navBar];
        _menuPresented = YES;
    }
}

- (AKLookupsListViewController *)listVC {
    if (!_listVC){
        _listVC = [[AKLookupsListViewController alloc] initWithParentViewController:self];
        _listVC.dataSource = self;
        _listVC.delegate = self;
        _listVC.bottomMargin = 15.0f;
    }
    return _listVC;
}

#pragma Filters methods

- (IBAction)btnFilter_Click:(id)sender {
    SelectFilterViewController *selectFilterViewController = (SelectFilterViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"SelectFilterViewController"];
    selectFilterViewController.sizeDelegate = self;
    [self presentViewController:selectFilterViewController animated:YES completion:nil];
}

- (void)sizeSelectionCompleted:(NSMutableArray *)selectedSizeList {
    NSString *sizes = @"";
    for (int i = 0; i < [selectedSizeList count]; i++)
    {
        if(![sizes isEqualToString:@""])
            sizes = [sizes stringByAppendingString:@","];
        sizes = [sizes stringByAppendingString:[(SizeGroup *)[selectedSizeList objectAtIndex:i] Name]];
        NSLog(@"%@", sizes);
        //selectedSize = (SizeGroup *) [selectedSizeList objectAtIndex:i];
    }
}

- (void)categorySelectionCompleted:(NSMutableArray *)selectedCategoryList {
    NSString *category = @"";
    for (int i = 0; i < [selectedCategoryList count]; i++)
    {
        if(![category isEqualToString:@""])
            category = [category stringByAppendingString:@","];
        category = [category stringByAppendingString:[(ItemCategory *)[selectedCategoryList objectAtIndex:i] Name]];
        NSLog(@"%@", category);
        //selectedSize = (SizeGroup *) [selectedSizeList objectAtIndex:i];
    }
}

- (void)brandSelectionCompleted:(NSMutableArray *)selectedBrandList {
    NSString *brand = @"";
    for (int i = 0; i < [selectedBrandList count]; i++)
    {
        if(![brand isEqualToString:@""])
            brand = [brand stringByAppendingString:@","];
        brand = [brand stringByAppendingString:[(ItemBrand *)[selectedBrandList objectAtIndex:i] Name]];
        NSLog(@"%@", brand);
        //selectedSize = (SizeGroup *) [selectedSizeList objectAtIndex:i];
    }
}

@end
