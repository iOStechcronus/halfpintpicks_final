//
//  CartViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "CartViewController.h"
#import "CartShippingIViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController
{
    int selectedIndex;
    NSMutableArray *arrCartdata;
    int subtotalPrice;
    float shipingPrice;
}

@synthesize selectionImage,cellHeightConstant,scrollView,lblShippingPrice,lblSubtotalPrice,lblTotalPrice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrCartdata = [[NSMutableArray alloc]init];
    [self SetUIApperence];
    //[self StaticData];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [scrollView setFrame:CGRectMake(0, 98, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight] - 49 - 98 - 50)];
    [scrollView setContentSize:CGSizeMake(320, 550)];
    [self StaticData];
}

//This is just static method to load static data for testing
- (void)StaticData {
    ItemDetails *itemInfo = [[ItemDetails alloc]init];
    itemInfo.TotalUserItemCommentCount = 123;
    itemInfo.TotalUserItemLikeCount = 1244;
    itemInfo.ItemFrontImage = @"baby_1.png";
    itemInfo.ItemName = @"Baby care whell chair ";
    itemInfo.ItemPrice = [@"780" intValue];
    itemInfo.Size = @"6mo-12mo";
    itemInfo.OriginalPriceDec = [@"1400" doubleValue];
    arrCartdata = [[NSMutableArray alloc]init];
    [arrCartdata addObject:itemInfo];
    [arrCartdata addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"111" intValue];
    itemInfo.OriginalPriceDec = [@"134" doubleValue];
    itemInfo.TotalUserItemCommentCount = 111;
    itemInfo.TotalUserItemLikeCount = 222;
    itemInfo.Size = @"6mo-16mo";
    itemInfo.ItemFrontImage = @"baby_1.png";
    itemInfo.ItemName = @"Baby care whell chair 2 ";
    [arrCartdata addObject:itemInfo];
    [arrCartdata addObject:itemInfo];
    
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"2222" intValue];
    itemInfo.Size = @"8mo-17mo";
    itemInfo.OriginalPriceDec = [@"2345" doubleValue];
    itemInfo.TotalUserItemCommentCount = 444;
    itemInfo.TotalUserItemLikeCount = 555;
    itemInfo.ItemFrontImage = @"baby_2.png";
    itemInfo.ItemName = @"Baby care whell chair 4 on the way ";
    [arrCartdata addObject:itemInfo];
    [arrCartdata addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"111" intValue];
    itemInfo.Size = @"9mo-12mo";
    itemInfo.OriginalPriceDec = [@"12345" doubleValue];
    itemInfo.TotalUserItemCommentCount = 343;
    itemInfo.TotalUserItemLikeCount = 654;
    itemInfo.ItemFrontImage = @"baby_3.png";
    itemInfo.ItemName = @"Baby care whell chair 4 on the way ";
    [arrCartdata addObject:itemInfo];
    [arrCartdata addObject:itemInfo];
    
    itemInfo = [[ItemDetails alloc]init];
    itemInfo.ItemPrice = [@"5555" intValue];
    itemInfo.Size = @"XXL-XL";
    itemInfo.OriginalPriceDec = [@"5677" doubleValue];
    itemInfo.TotalUserItemCommentCount = 333;
    itemInfo.TotalUserItemLikeCount = 4444;
    itemInfo.ItemFrontImage = @"baby_1.png";
    itemInfo.ItemName = @"Baby care whell chair 5 on the way ";
    [arrCartdata addObject:itemInfo];
    
    [self Setscrollview];
    [self calculateSubtotal];
}

//Method to set scrollview contain
-(void)Setscrollview {
    cellHeightConstant.constant = ([arrCartdata count]) * 65.0f + 20;
    [self.tblCartDetails reloadData];
    [self.scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 100 + cellHeightConstant.constant)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], self.scrollView.frame.size.height) animated:YES];
}

//Method to calculate subtotal
-(void)calculateSubtotal {
    subtotalPrice = 0;
    for(ItemDetails * itemInfo in arrCartdata)
    {
        subtotalPrice += itemInfo.ItemPrice;
    }
    NSLog(@"New Subtotal :%d",subtotalPrice);
    lblSubtotalPrice.text = [NSString stringWithFormat:@"$ %d",subtotalPrice];
    shipingPrice = 12.99;
    lblShippingPrice.text= @"$ 12.99";
    float newTotal = (float)subtotalPrice + shipingPrice;
     NSLog(@"New Total :%f",[lblShippingPrice.text floatValue]);
    lblTotalPrice.text = [NSString stringWithFormat:@"$ %.2f",newTotal];
}

//Intial method to set all UI related changes at intial level
-(void)SetUIApperence {
    self.btnCart.backgroundColor = [UIColor clearColor];
    self.btnPayment.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    self.btnShipping.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    selectedIndex = FirstIndex;
    self.tblCartDetails.scrollEnabled = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Tableview Datasource and Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrCartdata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CartDetailsCell";
    CartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil)
        cell = [[CartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ItemDetails *itemInfo = (ItemDetails *)[arrCartdata objectAtIndex:indexPath.row];
    cell.imgProduct.image = [UIImage imageNamed:itemInfo.ItemFrontImage];
    cell.lblProductName.text = itemInfo.ItemName;
    cell.lblCurrentPrice.text = [NSString stringWithFormat:@"$ %d",itemInfo.ItemPrice];
    cell.lblOriginalPrice.text = [NSString stringWithFormat:@"$ %d",(int)itemInfo.OriginalPriceDec];
    cell.lblProductSize.text = itemInfo.Size;
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

//Checkout button click
- (IBAction)btnCheckout_click:(id)sender {
    CartShippingIViewController *cartShippingInfo = (CartShippingIViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CartShippingIViewController"];
    cartShippingInfo.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:cartShippingInfo animated:YES];
}
@end
