//
//  BillingInfoViewController.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 23/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "BillingInfoViewController.h"


#define STRIPE_TEST_PUBLIC_KEY @"pk_test_61U9Ep7ja1dwFFeoGs0UMQTx"
#define STRIPE_TEST_POST_URL @""

@interface BillingInfoViewController ()

@end

@implementation BillingInfoViewController
{
    NSString *validationString;
    NSString *requiredFieldValidationMessage;
}

@synthesize navItem, scrollView, btnCancel, btnSave;
@synthesize lblBilling, lblCardDetails, lblCVCode, lblExpiration, lblName, lblPaymentDetails, lblZipCode;;
@synthesize txtCardNumber, txtCVCode, txtMonth, txtNameOnCard, txtYear, txtZip;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
    txtCardNumber.delegate = self;
    txtCVCode.delegate = self;
    txtMonth.delegate = self;
    txtNameOnCard.delegate = self;
    txtYear.delegate = self;
    txtZip.delegate = self;
    [self viewInitialization];
}

- (void)viewWillAppear:(BOOL)animated {
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake([HelperMethod GetDeviceWidth], 420);
    [scrollView setFrame:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
    [scrollView scrollRectToVisible:CGRectMake(0, 64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:YES];
    
}

- (void)viewInitialization {
    lblName.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_Name"];
    txtNameOnCard.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_placeholder_Name"];
    lblPaymentDetails.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_PaymentDetails"];
    lblCardDetails.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_CardDetails"];
    txtCardNumber.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_placehoder_CardNumber"];
    lblExpiration.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_Expiration"];
    txtMonth.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_plcaceholder_Month"];
    txtYear.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_plcaholder_Year"];
    lblCVCode.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_CVCode"];
    txtCVCode.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_placeholder_CVCode"];
    lblBilling.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_Billing"];
    lblZipCode.text = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_lbl_ZipCode"];
    txtZip.placeholder = [HelperMethod GetLocalizeTextForKey:@"BillingInfo_placeholder_ZipCode"];

   [scrollView setUserInteractionEnabled:YES];
   UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
   tapGeature.cancelsTouchesInView = NO;
   [scrollView addGestureRecognizer:tapGeature];
   requiredFieldValidationMessage= [HelperMethod GetLocalizeTextForKey:@"VALIDATION_FIELDS_REQUIRED"];
}

- (void)RevertEditing {
    [self.view endEditing:YES];
    [scrollView setContentSize:CGSizeMake(320, 420)];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];
    //[scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//To display loading view
- (void)displayLoadingView {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = [HelperMethod GetLocalizeTextForKey:@"INVITATIONCODE_VERIFYT_HUD_TEXT"];
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

#pragma TextField Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(IS_IPHONE && !IS_IPHONE_5)
    {
        if([txtCardNumber isEqual:textField] || [txtMonth isEqual:textField] || [txtYear isEqual:textField] || [txtCVCode isEqual:textField] )
        {
            [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 650)];
            [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y -20, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
        else if([txtZip isEqual:textField])
        {
    
                [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 650)];
                [scrollView scrollRectToVisible:CGRectMake(0, scrollView.frame.size.height - 20, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
        
    }
    else if (IS_IPHONE_5)
    {
        if([txtZip isEqual:textField])
        {
            [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 650)];
            [scrollView scrollRectToVisible:CGRectMake(0, scrollView.frame.size.height - 20, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtNameOnCard isEqual:textField])
    {
        [txtNameOnCard resignFirstResponder];
        [txtCardNumber becomeFirstResponder];
    }
    else if ([txtCardNumber isEqual:textField])
    {
        [txtCardNumber resignFirstResponder];
        [txtMonth becomeFirstResponder];
    }
    else if ([txtMonth isEqual:textField])
    {
        [txtMonth resignFirstResponder];
        [txtYear becomeFirstResponder];
    }
    else if ([txtYear isEqual:textField])
    {
        [txtYear resignFirstResponder];
        [txtCVCode becomeFirstResponder];
    }
    else if ([txtCVCode isEqual:textField])
    {
        [txtCVCode resignFirstResponder];
        [txtZip becomeFirstResponder];
    }
    else if ([txtZip isEqual:textField])
    {
        [txtZip resignFirstResponder];
        [self RevertEditing];
    }
    
    return YES;
}

- (NSString *)requireFieldsValidations {
    validationString = @"";
    if ([self.txtNameOnCard.text length] == 0)
        validationString = lblName.text;
    
    if ([self.txtCardNumber.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblCardDetails.text];
    }
    
    if ([self.txtMonth.text length] == 0 || [self.txtYear.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblExpiration.text];
    }
    if ([self.txtCVCode.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblCVCode.text];
    }
    if ([self.txtZip.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblZipCode.text];
    }
    return validationString;
}

- (IBAction)btnCancel_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        [self displayLoadingView];
        
        self.stripeCard = [[STPCard alloc] init];
        self.stripeCard.name = self.txtNameOnCard.text;
        self.stripeCard.number = self.txtCardNumber.text;
        self.stripeCard.cvc = self.txtCVCode.text;
        self.stripeCard.expMonth = [self.txtMonth.text integerValue];
        self.stripeCard.expYear = [self.txtYear.text integerValue];
        self.stripeCard.addressZip = self.txtZip.text ;
        
        if ([self validateCustomerInfo]) {
            [self performStripeOperation];
        }
        else
        {
            UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"VALIDATION_CARDDETAILS"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [codeAlert show];
        }
        
    }
  //  [self.navigationController popViewControllerAnimated:YES];
}

#pragma Stripe card validations methods
- (BOOL)validateCustomerInfo {
    
    //2. Validate card number, CVC, expMonth, expYear
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    //3
    if (error) {
        return NO;
    }
    
    return YES;
}

- (void)performStripeOperation {
    
    //1
    btnSave.enabled = NO;
    
    //2
    [Stripe createTokenWithCard:self.stripeCard
                 publishableKey:STRIPE_TEST_PUBLIC_KEY
                        success:^(STPToken* token) {
                            NSLog(@"%@",token.tokenId);
                            btnSave.enabled = YES ;
                            [self dismissLoadingView];
                            //[self postStripeToken:token.tokenId];
                        } error:^(NSError* error) {
                            [self handleStripeError:error];
                        }];
}

- (void)postStripeToken:(NSString* )token {
    
    //1
    NSURL *postURL = [NSURL URLWithString:STRIPE_TEST_POST_URL];
    AFHTTPClient* httpClient = [AFHTTPClient clientWithBaseURL:postURL];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //2
    NSInteger totalCents = 1000;
    
    //3
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"stripeAmount"] = [NSString stringWithFormat:@"%ld", (long)totalCents];
    postRequestDictionary[@"stripeCurrency"] = @"usd";
    postRequestDictionary[@"stripeToken"] = token;
    postRequestDictionary[@"stripeDescription"] = @"Purchase from RWPuppies iOS app!";
    
    //4
    NSMutableURLRequest* request = [httpClient requestWithMethod:@"POST" path:nil parameters:postRequestDictionary];
    
    self.httpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self chargeDidSucceed];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self chargeDidNotSuceed];
    }];
    
    [self.httpOperation start];
    
    self.btnSave.enabled = YES;
}

- (void)chargeDidSucceed {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Please enjoy your new pup."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
   
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)chargeDidNotSuceed {
    //2
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment not successful"
                                                    message:@"Please try again later."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)handleStripeError:(NSError *) error {
    
    //1
    if ([error.domain isEqualToString:@"StripeDomain"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    //2
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please try again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    self.btnSave.enabled = YES;
}
@end
