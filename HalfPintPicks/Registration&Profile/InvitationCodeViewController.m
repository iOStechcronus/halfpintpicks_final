//
//  InvitationCodeViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "InvitationCodeViewController.h"
#import "WelComeViewController.h"

@interface InvitationCodeViewController ()

@end

@implementation InvitationCodeViewController

@synthesize txtEmail,txtCode,btnJoin,btnEnter,lblAppname,lblCodetext,lblEmailtext,scrollView;

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
    [txtCode becomeFirstResponder];
    [scrollView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
    tapGeature.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tapGeature];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
    [scrollView setContentSize:CGSizeMake(320, 550)];
}


//Method to set scrollview position to intial conditions and end editing for textfields
- (void)RevertEditing {
    [self.view endEditing:YES];
    [scrollView setContentSize:CGSizeMake(320, 550)];
    [scrollView scrollRectToVisible:CGRectMake(0, -64, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];
    //[scrollView setFrame:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight])];
}

#pragma WebRequests
//Method to call web service to verify invitation code
- (void)VarifyInvitationCode {
    //TO Show loading view
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = [HelperMethod GetLocalizeTextForKey:@"INVITATIONCODE_VERIFYT_HUD_TEXT"];
    [HUD hide:YES afterDelay:30.0];
    
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:txtCode.text, @"invitecode",nil];
    NSMutableDictionary *dataTopost = [dict mutableCopy];
    
    urlString = [urlString stringByAppendingString:@"user/activationcodeverify/format/json"];
    
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataTopost options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    [apirequest sendJsonPostRequestwithurl:urlString postData:jsonString requestId:FirstRequest];
}

//Method to generate new invitation code for given email id
- (void)Invitationcoderequest {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = [HelperMethod GetLocalizeTextForKey:@"INVITATIONCODE_REQUEST_HUD_TEXT"];
    [HUD hide:YES afterDelay:30.0];
    
    
    NSString *urlString = [HelperMethod GetWebAPIBasePath];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          txtEmail.text, @"email",
                          nil];
    NSMutableDictionary *dataTopost = [dict mutableCopy];

    urlString = [urlString stringByAppendingString:@"user/activationcode/format/json"];
    
    ApiRequest *apirequest = [[ApiRequest alloc]init];
    apirequest.apiRequestDelegate = self;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataTopost options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    [apirequest sendJsonPostRequestwithurl:urlString postData:jsonString requestId:SecondRequest];
}

- (IBAction)Join_click:(id)sender {
    if(txtEmail.text.length > 0)
    {
        if([HelperMethod CheckInternetStatus])
        {
            [self Invitationcoderequest];
        }
        else
        {
            UIAlertView *internetError = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"INTERNETCONNECTION_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetError show];
        }
    }
    else
    {
        UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"VALIDATION_EMAIL_REQUIRED"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [codeAlert show];
    }
}

- (IBAction)Submit_click:(id)sender {
    if(txtCode.text.length > 0)
    {
        if([HelperMethod CheckInternetStatus])
        {
            [self VarifyInvitationCode];
        }
        else
        {
            UIAlertView *internetError = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"INTERNETCONNECTION_ERROR"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetError show];
        }
    }
    else
    {
        UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[HelperMethod GetLocalizeTextForKey:@"VALIDATION_INVITATIONCODE_REQUIRED"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [codeAlert show];
    }
}

//To display loading view
- (void)displayLoadingView {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = [HelperMethod GetLocalizeTextForKey:@"INVITATIONCODE_REQUEST_HUD_TEXT"];
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
    //NSString *responceString = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",responceString);
    NSDictionary* responceDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options:kNilOptions
                                                                         error:&error];
    NSLog(@"%@",responceDictionary);
    [self dismissLoadingView];
    if(requestId == FirstRequest)
    {
        NSLog(@"%d",FirstRequest);
        if([[responceDictionary valueForKey:@"status"] intValue] == Success)
        {
            [self saveDefault];
            WelComeViewController *welComeVC = (WelComeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"WelComeViewController"];
            [self presentViewController:welComeVC animated:YES completion:nil];
        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
    else if (requestId == SecondRequest)
    {
        NSLog(@"%d",SecondRequest);
        if([[responceDictionary valueForKey:@"status"] intValue] == Success)
        {
            UIAlertView *successRegisteredAlertView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:@"." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successRegisteredAlertView show];
        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
    
}

//Save Code in app's to UserDefauls 
- (void)saveDefault {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:txtCode.text forKey:@"INVITATIONCODE"];
    [defaults synchronize];
}

#pragma TextField Related Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([txtEmail isEqual:textField])
    {
        [txtEmail resignFirstResponder];
        [self RevertEditing];
    }
    else if ([txtCode isEqual:textField])
    {
        [txtCode resignFirstResponder];
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([txtEmail isEqual:textField])
    {
        [scrollView setContentSize:CGSizeMake(320, 720)];
        [scrollView scrollRectToVisible:CGRectMake(0, scrollView.frame.size.height - 190, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    return YES;
}

@end
