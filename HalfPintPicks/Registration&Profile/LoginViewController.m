//
//  LoginViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "LoginViewController.h"
#import "TabbarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    NSString *validationString;
    NSString *requiredFieldValidationMessage;
}
@synthesize txtEMail,txtPassword;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method to Intilization of intial variables and methods
- (void)Intilization {
    txtEMail.text = @"javiyavandan@gmail.com";
    txtPassword.text = @"123456";
    txtPassword.delegate = self;
    txtEMail.delegate = self;
    [txtEMail becomeFirstResponder];
    requiredFieldValidationMessage= [HelperMethod GetLocalizeTextForKey:@"VALIDATION_FIELDS_REQUIRED"];
}

- (IBAction)Login_Click:(id)sender {
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
        [self Sendloginrequest];
       
    }
    
//    TabbarViewController *tabVC = (TabbarViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
//    [tabVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//    [self presentViewController:tabVC animated:YES completion:nil];
}

- (IBAction)Close_Click:(id)sender {
    [txtEMail resignFirstResponder];
    [txtPassword resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma WebRequests
- (void)Sendloginrequest {
    [self.view endEditing:YES];
    if([HelperMethod CheckInternetStatus])
    {
        [self displayLoadingView];
        
        NSString *urlString = [HelperMethod GetWebAPIBasePath];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:txtEMail.text, @"email",
                              txtPassword.text, @"password", nil];
        NSMutableDictionary *dataTopost = [dict mutableCopy];
        
        urlString = [urlString stringByAppendingString:@"user/login/format/json"];
        
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
            UserDetails *userInfo = [JSONParser ParseUserInfoFromJSONData:[responceDictionary valueForKey:@"data"]];
//            if(userInfo.IsActive)
//            {
                TabbarViewController *tabVC = (TabbarViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
                [tabVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                [self presentViewController:tabVC animated:YES completion:nil];
//            }
//            else
//            {
//                
//            }
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
    if ([self.txtEMail.text length] == 0)
        validationString = txtEMail.placeholder;
    
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
    if ([self.txtEMail.text length] > 0 && ![HelperMethod IsValidEmail:self.txtEMail.text Strict:NO])
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

#pragma TextField Related Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtEMail isEqual:textField])
    {
        [txtEMail resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else if ([txtPassword isEqual:textField])
    {
        [txtPassword resignFirstResponder];
        //[self Sendloginrequest];
    }
    return YES;
}

@end
