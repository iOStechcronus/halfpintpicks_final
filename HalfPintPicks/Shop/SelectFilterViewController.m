//
//  SelectFilterViewController.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 13/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "SelectFilterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SelectFilterViewController ()

@end

@implementation SelectFilterViewController {
    int selectedIndex;
    NSMutableArray *arrBrands;
    NSMutableArray *arrCategories;
    NSMutableArray *arrSizes;
}

@synthesize navItem, btnCancel, btnSave, btnBrand, btnCategory, btnSize, lblHeaderText, scrollImage;

@synthesize vwHeader, vwBrand, vwCategory, vwSizeCollection, tblBrand, tblCategory, selectedCategoryList, selectedSizeList, selectedBrandList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:66/255.0f green:76/255.0f blue:77/255.0f alpha:1.0f]}];
    navItem.title = @"Filter";
    btnSave.title = @"Done";
    btnCancel.title = @"Cancel";
    lblHeaderText.text = @"Who is this for?";
    btnCategory.titleLabel.text = @"Category";
    btnSize.titleLabel.text = @"Size";
    btnBrand.titleLabel.text = @"Brand";
    [self viewInitialization];
}

- (void)viewInitialization {
    vwCategory.hidden = NO;
    vwSizeCollection.hidden = YES;
    vwBrand.hidden = YES;
    selectedIndex = FirstIndex;
    vwSizeCollection.backgroundColor = [UIColor clearColor];
    //[self Getalldata];
    [self StaticData];
    
}

//This is just static method to load static data for testing
- (void)StaticData {
    arrBrands = [[NSMutableArray alloc] init];
    arrCategories = [[NSMutableArray alloc] init];
    arrSizes = [[NSMutableArray alloc] init];
    
    ItemCategory *itemCategory = [[ItemCategory alloc] init];
    itemCategory.Name = @"Shirts";
    itemCategory.CategoryId = 1;
    [arrCategories addObject:itemCategory];
    
    itemCategory = [[ItemCategory alloc] init];
    itemCategory.Name = @"T-Shirts";
    itemCategory.CategoryId = 2;
    [arrCategories addObject:itemCategory];
    
    itemCategory = [[ItemCategory alloc] init];
    itemCategory.Name = @"Ties";
    itemCategory.CategoryId = 3;
    [arrCategories addObject:itemCategory];
    
    itemCategory = [[ItemCategory alloc] init];
    itemCategory.Name = @"Pents";
    itemCategory.CategoryId = 4;
    [arrCategories addObject:itemCategory];
    
    ItemBrand * brand = [[ItemBrand alloc] init];
    brand.BrandId = 1;
    brand.Name = @"Nike";
    [arrBrands addObject:brand];
    
    brand = [[ItemBrand alloc] init];
    brand.BrandId = 2;
    brand.Name = @"Reebok";
    [arrBrands addObject:brand];
    
    brand = [[ItemBrand alloc] init];
    brand.BrandId = 3;
    brand.Name = @"Denim";
    [arrBrands addObject:brand];
    
    brand = [[ItemBrand alloc] init];
    brand.BrandId = 4;
    brand.Name = @"Lee copper";
    [arrBrands addObject:brand];
    
    brand = [[ItemBrand alloc] init];
    brand.BrandId = 5;
    brand.Name = @"Levies";
    [arrBrands addObject:brand];
    
    brand = [[ItemBrand alloc] init];
    brand.BrandId = 6;
    brand.Name = @"TQS";
    [arrBrands addObject:brand];
    
    SizeGroup *size = [[SizeGroup alloc] init];
    size.Name = @"XL";
    size.Id = 1;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"L";
    size.Id = 2;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"M";
    size.Id = 3;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"XXL";
    size.Id = 4;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"S";
    size.Id = 5;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"S-36";
    size.Id = 6;
    [arrSizes addObject:size];
    
    size = [[SizeGroup alloc] init];
    size.Name = @"16-36";
    size.Id = 7;
    [arrSizes addObject:size];
    
    [tblBrand reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancel_Click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSave_Click:(id)sender {
    if(self.sizeDelegate != nil) {
        if ([selectedSizeList count] != 0)
         [self.sizeDelegate sizeSelectionCompleted:selectedSizeList];
        if ([selectedCategoryList count] != 0)
            [self.sizeDelegate categorySelectionCompleted:selectedCategoryList];
        if ([selectedBrandList count] != 0)
            [self.sizeDelegate brandSelectionCompleted:selectedBrandList];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SegmentChanged_Click:(id)sender {
    UIButton *btnSelected = (UIButton *)sender;
    if(btnSelected.tag == 15)
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(0, 0, scrollImage.frame.size.width, scrollImage.frame.size.height);
            btnCategory.backgroundColor = [UIColor clearColor];
            btnSize.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            btnBrand.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];
        
        if(selectedIndex == SecondIndex)
        {
            [self fadeOutView:vwSizeCollection];
            [self fadeinView:vwCategory];
        }
        else if (selectedIndex == ThirdIdex)
        {
            [self fadeOutView:vwBrand];
            [self fadeinView:vwCategory];
        }
        selectedIndex = FirstIndex;
        [self.tblCategory reloadData];
    }
    else if (btnSelected.tag == 16)
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(107, 0, scrollImage.frame.size.width, self.scrollImage.frame.size.height);
            btnSize.backgroundColor = [UIColor clearColor];
            btnCategory.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            btnBrand.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];

        if(selectedIndex == FirstIndex)
        {
            [self fadeinView:vwSizeCollection];
            [self fadeOutView:vwCategory];
        }
        else if (selectedIndex == ThirdIdex)
        {
            [self fadeinView:vwSizeCollection];
            [self fadeOutView:vwBrand];
        }
        selectedIndex = SecondIndex;
        [self.vwSizeCollection reloadData];
    }
    else
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(214, 0, self.scrollImage.frame.size.width, self.scrollImage.frame.size.height);
            btnBrand.backgroundColor = [UIColor clearColor];
            btnCategory.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            btnSize.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        } completion:^(BOOL complete) {
            
        }];
        
        if(selectedIndex == FirstIndex)
        {
            [self fadeinView:vwBrand];
            [self fadeOutView:vwCategory];
        }
        else if (selectedIndex == SecondIndex)
        {
            [self fadeinView:vwBrand];
            [self fadeOutView:vwSizeCollection];
        }
        selectedIndex = ThirdIdex;
        [self.tblBrand reloadData];
    }
}

#pragma Custom Methods
- (void)fadeinView:(UIView *)viewtofadein {
    [viewtofadein setAlpha:0.0f];
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [viewtofadein setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [viewtofadein setHidden:NO];
    }];
}

- (void)fadeOutView:(UIView *)viewtofadeout {
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [viewtofadeout setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [viewtofadeout setHidden:YES];
    }];
}

#pragma HUD Methods
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

#pragma Selection Request to get all data
- (void)Getalldata {
    [self displayLoadingView];
    ApiRequest *apirequest = [[ApiRequest alloc] init];
    apirequest.apiRequestDelegate = self;
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];
    [apirequest sendJsonGetRequestwithurl:urlString requestId:FirstRequest];
}

#pragma WebRequests callback Delagate Methods
- (void)apiRequestCompletedWithError:(NSString *)errorString requestId:(int)requestId{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"ALERT_WEBSERVICE_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    errorAlertView.tag = 1;
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
        //arrCategories = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"categories"]];
        //arrSizes = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"sizes"]];
        //arrBrands = [JSONParser ParseItemCategoryFromJsonData:[responceDictionary objectForKey:@"brands"]];
        [vwSizeCollection reloadData];
        [tblBrand reloadData];
        [tblCategory reloadData];
    }
    else
    {
        UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [registrationErrorView show];
    }
}

#pragma Tableview Delegate and Data source methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isEqual:tblBrand]) {
        return [arrBrands count];
    }
    else if([tableView isEqual:tblCategory]) {
        return [arrCategories count];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:tblBrand]) {
        static NSString *CellIdentifier = @"BrandCell";

        UITableViewCell *cell = nil;
        if (cell == nil)
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ItemBrand *itemBrand = [arrBrands objectAtIndex:indexPath.row];
        cell.textLabel.text = itemBrand.Name;
        return cell;
    }
    else if ([tableView isEqual:tblCategory]) {
        static NSString *CellIdentifier = @"CategoryCell";
        
        UITableViewCell *cell = nil;
        if (cell == nil)
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ItemCategory *itemCategory = [arrCategories objectAtIndex:indexPath.row];
        cell.textLabel.text = itemCategory.Name;
        return cell;

    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:tblBrand]) {
        [[tblBrand cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        selectedBrandList = [[NSMutableArray alloc] init];
        ItemBrand *selectedBrand = [arrBrands objectAtIndex:indexPath.row];
        [selectedBrandList addObject:selectedBrand];
    }
    else {
        [[tblCategory cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        selectedCategoryList = [[NSMutableArray alloc] init];
        ItemCategory *selectedCategory = [arrCategories objectAtIndex:indexPath.row];
        [selectedCategoryList addObject:selectedCategory];
    }
}

#pragma Collectionview Delegate and Data source methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [arrSizes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UILabel *sizeGroupLabel = (UILabel *)[cell viewWithTag:10];
    SizeGroup *size = (SizeGroup *) [arrSizes objectAtIndex:indexPath.row];
    sizeGroupLabel.text = size.Name;
    sizeGroupLabel.textAlignment = NSTextAlignmentCenter;
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backGroundView.layer.borderWidth = 0.3;
    backGroundView.layer.borderColor = [UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1.0].CGColor;
    cell.backgroundView = backGroundView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionViewCell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *sizeGroupLabel = (UILabel *)[collectionViewCell viewWithTag:10];
    sizeGroupLabel.textColor = [UIColor whiteColor];
    sizeGroupLabel.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0];
    UIView *backGroundView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
    backGroundView.layer.borderWidth = 0.3;
    backGroundView.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:70.0/255.0 blue:76.0/255.0 alpha:1.0];
    backGroundView.layer.borderColor = [UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1.0].CGColor;
    collectionViewCell.selectedBackgroundView = backGroundView;
    selectedSizeList = [[NSMutableArray alloc] init];
    SizeGroup *selectedSize = [arrSizes objectAtIndex:indexPath.row];
    [selectedSizeList addObject:selectedSize];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionViewCell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *sizeGroupLabel = (UILabel *)[collectionViewCell viewWithTag:10];
    sizeGroupLabel.textColor = [UIColor colorWithRed:66.0/255.0 green:74.0/255.0 blue:73.0/255.0 alpha:1.0];
    sizeGroupLabel.backgroundColor = [UIColor whiteColor];
    UIView *backGroundView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
    backGroundView.layer.borderWidth = 0.3;
    backGroundView.layer.borderColor = [UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1.0].CGColor;
    collectionViewCell.selectedBackgroundView = backGroundView;
    SizeGroup *selectedSize = [arrSizes objectAtIndex:indexPath.row];
    [selectedSizeList removeObject:selectedSize];
}

@end
