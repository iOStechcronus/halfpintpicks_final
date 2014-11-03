//
//  RegisterViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "RegisterViewController.h"
#import "TabbarViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
{
    NSString *validationString;
    NSString *requiredFieldValidationMessage;
}

@synthesize txtEmail,btnClose,btnJoin,lblApptitle,lblInfoText,txtPassword,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Intilization];
    // Do any additional setup after loading the view.
}

//Method to Intilization of intial variables and methods
- (void)Intilization {
    txtEmail.delegate = self;
    txtPassword.delegate = self;
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    [scrollView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
    tapGeature.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tapGeature];
    requiredFieldValidationMessage= [HelperMethod GetLocalizeTextForKey:@"VALIDATION_FIELDS_REQUIRED"];
    
}

//Method to set scrollview position to intial conditions and end editing for textfields
- (void)RevertEditing {
    [self.view endEditing:YES];
    [scrollView setContentSize:CGSizeMake(320, 550)];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];
    //[scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

- (void)viewWillAppear:(BOOL)animated {
    [scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
    [scrollView setContentSize:CGSizeMake(320, 550)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Join_Click:(id)sender {
    validationString = [self requireFieldsValidations];
    NSString *otherValidations = [self otherValidations];
    if ([validationString length] > 0)
        validationString = [requiredFieldValidationMessage stringByAppendingString:validationString];
    
    if ([otherValidations length] > 0)
    {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:otherValidations];
    }
    if ([validationString length] > 0)
    {
        UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:validationString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [codeAlert show];
    }
    else
    {
        [self Registrationrequest];
        
    }
}

- (IBAction)Close_click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Send Register Request
- (void)Registrationrequest {
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:txtEmail.text, @"email",
                              txtPassword.text, @"password", nil];
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

#pragma WebRequests callback Delagate Methods
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
            TabbarViewController *tabVC = (TabbarViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
            [tabVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self presentViewController:tabVC animated:YES completion:nil];
        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
}

//Required filed validatons for all text controls
- (NSString *)requireFieldsValidations {
    validationString = @"";
    if ([self.txtEmail.text length] == 0)
        validationString = txtEmail.placeholder;
    
    if ([self.txtPassword.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:txtPassword.placeholder];
    }
    return validationString;
}

//Other validations for email
- (NSString *)otherValidations {
    NSString *otherValidations;
    if ([self.txtEmail.text length] > 0 && ![HelperMethod IsValidEmail:self.txtEmail.text Strict:NO])
        otherValidations = [HelperMethod GetLocalizeTextForKey:@"Validations_EmailValidationMessage"];
    return otherValidations;
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

#pragma TextField Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(IS_IPHONE && !IS_IPHONE_5)
    {
//        if([txtPassword isEqual:textField])
//        {
//            [scrollView setContentSize:CGSizeMake(320, 600)];
//            [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y -20, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
//        }
//        else if ([txtEmail isEqual:textField])
//        {
            [scrollView setContentSize:CGSizeMake(320, 600)];
            [scrollView scrollRectToVisible:CGRectMake(0, scrollView.frame.size.height - 10 , [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        //}

    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtEmail isEqual:textField])
    {
        [txtEmail resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else if ([txtPassword isEqual:textField])
    {
        [txtPassword resignFirstResponder];
        [self RevertEditing];
    }
    return YES;
}

@end
