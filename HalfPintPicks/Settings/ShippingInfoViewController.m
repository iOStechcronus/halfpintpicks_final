//
//  ShippingInfoViewController.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 19/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "ShippingInfoViewController.h"

@interface ShippingInfoViewController ()

@end

@implementation ShippingInfoViewController
{
    NSString *validationString;
    NSString *requiredFieldValidationMessage;
}

@synthesize navItem, btnCancel, btnSave, scrollView, mainContainerView;
@synthesize lblAddressOne, lblAddressTwo, lblCity, lblInstruction, lblName, lblState, lblZip;
@synthesize txtAddressTwo, txtCity, txtEnterName, txtEnterState, txtEnterZip, txtStreetAddress;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Intilization];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Intilization {
    [scrollView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
    tapGeature.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tapGeature];
    requiredFieldValidationMessage= [HelperMethod GetLocalizeTextForKey:@"VALIDATION_FIELDS_REQUIRED"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [scrollView setFrame:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
    [scrollView setContentSize:CGSizeMake(320, 550)];
}

- (void)RevertEditing {
    [self.view endEditing:YES];
    [scrollView setContentSize:CGSizeMake(320, 550)];
    [scrollView scrollRectToVisible:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];
    [scrollView setFrame:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

#pragma Send Requests
- (void)SaveShippingInfo {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:txtEnterName.text, @"name",
                              txtStreetAddress.text, @"streetaddress",txtAddressTwo.text, @"address2",txtCity.text, @"city",txtEnterState.text, @"state",txtEnterZip.text, @"zipcode", nil];
        NSMutableDictionary *dataTopost = [dict mutableCopy];
        
        urlString = [urlString stringByAppendingString:@"user/saveuser/format/json"];
        
        ApiRequest *apirequest = [[ApiRequest alloc]init];
        apirequest.apiRequestDelegate = self;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataTopost options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        [apirequest sendJsonPostRequestwithurl:urlString postData:jsonString requestId:FirstRequest];
    }
    else
    {
        UIAlertView *internetError = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"INTERNETCONNECTION_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [internetError show];
    }
    
    
}

#pragma Requests callback Delagate Methods
- (void)apiRequestCompletedWithError:(NSString *)errorString requestId:(int)requestId{
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"ALERT_WEBSERVICE_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];;
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
            UIAlertView *updatedSuccessAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"VALIDATION_ADDRESS_UPDATED"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            updatedSuccessAlert.tag =1;
            [updatedSuccessAlert show];
        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSString *)requireFieldsValidations {
    validationString = @"";
    if ([self.txtEnterName.text length] == 0)
        validationString = lblName.text;
    
    if ([self.txtStreetAddress.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblAddressOne.text];
    }
    
    if ([self.txtCity.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblCity.text];
    }
    if ([self.txtEnterState.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblState.text];
    }
    if ([self.txtEnterZip.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblZip.text];
    }
    return validationString;
}

//To display loading view
- (void)displayLoadingView {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = [HelperMethod GetLocalizeTextForKey:@"LOADING_HUD_TEXT"];
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

- (IBAction)btnCancel_Click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSave_Click:(id)sender {
    validationString = [self requireFieldsValidations];
    if ([validationString length] > 0)
        validationString = [requiredFieldValidationMessage stringByAppendingString:validationString];
    
    if ([validationString length] > 0)
    {
        UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:validationString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [codeAlert show];
    }
    else
    {
        [self SaveShippingInfo];
    }

}

#pragma TextField Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(IS_IPHONE && !IS_IPHONE_5)
    {
        if([txtCity isEqual:textField] || [txtEnterState isEqual:textField] || [txtEnterZip isEqual:textField])
                {
                    [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 650)];
                    [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y -20, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
                }
        
        
    }
    else if (IS_IPHONE_5)
    {
        if([txtEnterZip isEqual:textField])
        {
            [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 580)];
            [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y -  5, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtEnterName isEqual:textField])
    {
        [txtEnterName resignFirstResponder];
        [txtStreetAddress becomeFirstResponder];
    }
    else if ([txtStreetAddress isEqual:textField])
    {
        [txtStreetAddress resignFirstResponder];
        [txtAddressTwo becomeFirstResponder];
    }
    else if ([txtAddressTwo isEqual:textField])
    {
        [txtAddressTwo resignFirstResponder];
        [txtCity becomeFirstResponder];
    }
    else if ([txtCity isEqual:textField])
    {
        [txtCity resignFirstResponder];
        [txtEnterState becomeFirstResponder];
    }
    else if ([txtEnterState isEqual:textField])
    {
        [txtEnterState resignFirstResponder];
        [txtEnterZip becomeFirstResponder];
    }
    else if ([txtEnterZip isEqual:textField])
    {
        [txtEnterZip resignFirstResponder];
        [self RevertEditing];
    }
    
    return YES;
}
@end
