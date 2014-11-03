//
//  WelComeViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "WelComeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "JSONParser.h"
#import "UserDetails.h"

//Define OAuthConsumerKey and OAuthConsumerSecret of application for twitter integration
#define kOAuthConsumerKey @"hPY0bLa7CeWH8MiiBOmLpeSbW"
#define kOAuthConsumerSecret @"o9oGS7m5emeVtXPnNTMRUG1PVcnZH8XcYXd8KbKWuuwAdRBMY4"

@interface WelComeViewController ()

@end

@implementation WelComeViewController {
    UserDetails *facebookUser;
    int currentImage;
    CGFloat pageWidth;
    NSTimer *sliderTimer;
    bool sliderDirection;
}

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
    [btnTwitter.layer setCornerRadius:3.0f];
    [btnLoginFacebook.layer setCornerRadius:3.0f];
    facebookUser = [[UserDetails alloc] init];
    
    [sliderTimer invalidate];
    sliderTimer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target: self selector:@selector(onTick:)
                                                 userInfo:nil repeats:YES];
    
    pageWidth = [HelperMethod GetDeviceWidth];
    currentImage = 0;

    sliderDirection = true;
    scrollView.contentSize = CGSizeMake(pageWidth * 3, scrollView.frame.size.height);
    CGPoint offset = CGPointMake(0, 0);
    [scrollView setContentOffset:offset animated:YES];
    scrollView.delegate = self;
    
//    pgControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page_control_active.png"]];
//    pgControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page_control_inactive.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Signup_Click:(id)sender {
    RegisterViewController *signUpVC = (RegisterViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:signUpVC animated:YES completion:nil];
}

- (IBAction)Login_Click:(id)sender {
    LoginViewController *loginVC = (LoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)FacebookLogin_Click:(id)sender {
    //This method will check the facebook session state and allow user to log in into app
    [self LoginWithFacebook];
}

//This methods will call facebook api to get user details
- (void)LoginWithFacebook {
    //This method is for opening and handling FB session
    if (!FBSession.activeSession.isOpen) {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_location", @"user_birthday"]
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              [HUD hide:YES];
                                          }
                                          else if (session.isOpen) {
                                              [self LoginWithFacebook];
                                          }
                                      }];
        return;
    }
    //This method is for Login into the app after authentication done from FB.
    [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        else {
            if(facebookUser == nil || facebookUser.FacebookUserId == nil || [facebookUser.FacebookUserId isEqualToString:@""])
            {
                facebookUser = [JSONParser ParseUserInfoFromFbJsonData:user];
                NSString *imageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",facebookUser.FacebookUserId];
                NSString *isLoginWithFacebook = @"true";
                if([HelperMethod CheckInternetStatus])
                {
                    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    HUD.delegate = self;
                    [HUD hide:YES afterDelay:30.0];
                    
                    NSString *urlString = [HelperMethod GetWebAPIBasePath];
                    
                    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:facebookUser.Email, @"email",facebookUser.FirstName, @"first_name",facebookUser.LastName,@"last_name",facebookUser.FacebookUserId,@"FacebookUserId",facebookUser.gender,@"gender",isLoginWithFacebook,@"isFacebookUser",imageURL,@"ProfileImageUrl",facebookUser.hometown,@"location", nil];
                    NSMutableDictionary *dataTopost = [dict mutableCopy];
                    
                    urlString = [urlString stringByAppendingString:@"user/login/format/json"];
                    
                    ApiRequest *apirequest = [[ApiRequest alloc]init];
                    apirequest.apiRequestDelegate = self;
                    
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataTopost options:0 error:nil];
                    NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                    
                    [apirequest sendJsonPostRequestwithurl:urlString postData:jsonString requestId:FirstRequest];

                    
                   }
            }
        }
    }];
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
    
    NSLog(@"%d",requestId);
    if(requestId == FirstRequest)
    {
        if([[responceDictionary valueForKey:@"status"] intValue] == Success)
        {
        }
        else
        {
            UIAlertView *registrationErrorView = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:[responceDictionary valueForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [registrationErrorView show];
        }
    }
}

- (IBAction)Twitter_Click:(id)sender {
   
}

//Currently not calling it was cancelled
- (void)LoginWithTwitter {
    //Check weather the app is authorized or not by the user.
   
    //If already authorized, then do code here for Login into app.
}

//Method called automatic when timer will fire as per set interval
- (void)onTick:(NSTimer *)timer {
    currentImage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(currentImage == 0)
    {
        currentImage = currentImage + 1;
        sliderDirection = true;
    }
    else if (currentImage == 2)
    {
        currentImage = currentImage - 1;
        sliderDirection = false;
    }
    else if(sliderDirection == true && currentImage == 1)
        currentImage = currentImage + 1;
    else if (sliderDirection == false && currentImage == 1)
        currentImage = currentImage - 1;
    [self changePage:currentImage];
}

//Chnage page is method to set scrollview offect as well as current page indexwhile scrollview ends moving
- (void)changePage:(int)imageNumber {
    CGPoint offset = CGPointMake(imageNumber * scrollView.frame.size.width, 0);
    pgControl.currentPage = imageNumber;
    [scrollView setContentOffset:offset animated:YES];
}

//Delegate methods of twitter engine to get & store data in user defaults
#pragma mark SA_OAuthTwitterEngineDelegate
- (void)storeCachedTwitterOAuthData:(NSString *)data forUsername:(NSString *)username {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: data forKey: @"authData"];
    [defaults synchronize];
}

- (NSString *)cachedTwitterOAuthDataForUsername:(NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

@end
