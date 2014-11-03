//
//  AddKidViewController.m
//  HalfPintPicks
//
//  Created by TechCronus on 07/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "AddKidViewController.h"

@interface AddKidViewController ()

@end

@implementation AddKidViewController
@synthesize lblKidname,lblStatictext,txtKidAge,txtKidClothSize,txtKidFirstname,txtKidShoeSize,imgCover,imgKidImage;

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
    [imgKidImage setImage:[UIImage imageNamed:@"Kid"]];
     [imgCover setImage:[UIImage imageNamed:@"cover_2"]];
    imgKidImage.layer.borderWidth = 1.0f;
    imgKidImage.layer.borderColor = [UIColor whiteColor].CGColor;
    imgKidImage.layer.cornerRadius = 37.0f;
    imgKidImage.layer.masksToBounds =YES;
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {
    
    [self.scrollView setFrame:CGRectMake(0,64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
    [self.scrollView setContentSize:CGSizeMake(320, 550)];
}

-(void)SetUIApperence {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)Saveandfinish_click:(id)sender {
    //[self AddKidRequest];
}

- (IBAction)Saveandaddanother_click:(id)sender {
    txtKidShoeSize.text = @"";
    txtKidFirstname.text = @"";
    txtKidClothSize.text = @"";
    txtKidAge.text = @"";
    //[self AddKidRequest];
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

#pragma TextField Related Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(IS_IPHONE && !IS_IPHONE_5 && [textField isEqual:txtKidFirstname])
    {
        [self.scrollView setContentSize:CGSizeMake(320, 720)];
        [self.scrollView scrollRectToVisible:CGRectMake(0, txtKidFirstname.frame.origin.y - 50, [HelperMethod GetDeviceWidth], self.scrollView.frame.size.height) animated:YES];
    }
    else if([textField isEqual:txtKidAge])
    {
        [self.scrollView setContentSize:CGSizeMake(320, 720)];
        [self.scrollView scrollRectToVisible:CGRectMake(0, txtKidAge.frame.origin.y - 10, [HelperMethod GetDeviceWidth], self.scrollView.frame.size.height) animated:YES];
    }
    else if([textField isEqual:txtKidClothSize] || [textField isEqual:txtKidShoeSize])
    {
        [self.scrollView setContentSize:CGSizeMake(320, 720)];
        [self.scrollView scrollRectToVisible:CGRectMake(0, txtKidClothSize.frame.origin.y - 10, [HelperMethod GetDeviceWidth], self.scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtKidFirstname isEqual:textField])
    {
        [txtKidFirstname resignFirstResponder];
        [txtKidAge becomeFirstResponder];
    }
    else if ([txtKidAge isEqual:textField])
    {
        [txtKidAge resignFirstResponder];
        [txtKidClothSize becomeFirstResponder];
        
        //[self Sendloginrequest];
    }
    else if ([txtKidClothSize isEqual:textField])
    {
        [txtKidClothSize resignFirstResponder];
        [txtKidShoeSize becomeFirstResponder];
        //[self Sendloginrequest];
    }
    else if ([txtKidShoeSize isEqual:textField])
    {
        [txtKidShoeSize resignFirstResponder];
        [self.scrollView setContentSize:CGSizeMake(320, 550)];
        [self.scrollView scrollRectToVisible:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], self.scrollView.frame.size.height) animated:NO];

    }
    
    return YES;
}

#pragma Requests
//FirstRequest
-(void)AddKidRequest {
    
    [self displayLoadingView];
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Test", @"Email",
                          nil];
    NSMutableDictionary *dataTopost = [dict mutableCopy];
    
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&Email=%@",@""]];

    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataTopost options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    [apirequest sendJsonPostRequestwithurl:urlString postData:jsonString requestId:FirstRequest];
}

#pragma Requests callback Delagate Methods
- (void)apiRequestCompletedWithError:(NSString *)errorString requestId:(int)requestId{
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:[[NSBundle mainBundle] valueForKey:@"CFBundleName"] message:@"Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
            UIAlertView *successRegisteredAlertView = [[UIAlertView alloc]initWithTitle:[[NSBundle mainBundle] valueForKey:@"CFBundleName"] message:@"Thank you for joining with us. \n Your email is successfully registered with us. Please check your email for Invitation code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successRegisteredAlertView show];
        }
    }
}

- (IBAction)Back_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
