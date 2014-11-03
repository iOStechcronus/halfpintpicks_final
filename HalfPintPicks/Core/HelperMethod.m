//
//  HelperMethod.m


#import "HelperMethod.h"
#import <sys/xattr.h>

@implementation HelperMethod

//Class method to fetch current culture from device prefrences
+(NSString *) GetCurrentCulture {
    NSString *language = @"";
    
    language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
     NSRange substr = NSMakeRange(0, 2);
    language = [language substringWithRange:substr];
    language = @"en-US";
    return  language;
}

//Class method to fetch localized text from localizable file for current culture
//Parameter : Key name
//Return : Value for key

+(NSString *) GetLocalizeTextForKey:(NSString *)key {
    NSString *currentLanguage = [self GetCurrentCulture];
    NSString *path;
    if([currentLanguage isEqualToString:@"en-US"])
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    else
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
    return str;
}

//Checking internet status
+(BOOL)CheckInternetStatus {
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == NotReachable)
        return NO;
    else
        return YES;
}

//Web service urls
+(NSString *) GetWebAPIBasePath {
    return @"http://www.techcronus.com/halfpintpicks/halfpints/index.php/api/";
}


+(BOOL) IsDeviceiPhone {
    UIDevice* thisDevice = [UIDevice currentDevice];
    return !(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

//Current device width
+(CGFloat) GetDeviceWidth {
    return [GeneralDeclaration generalDeclaration].screenWidth;
}

//Current device height
+(CGFloat) GetDeviceHeight {
    return [GeneralDeclaration generalDeclaration].screenHeight;
}

//Current Story board
+(NSString *) GetStoryBoardName {
    return [GeneralDeclaration generalDeclaration].storyBoardName;
}

//Customized method for creating cutomized label fot navigation title view
+(UILabel * ) GetNavigationTitle:(NSString *)screenTitle {
    UILabel *navigationTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150, 35)];
    navigationTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    navigationTitle.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    navigationTitle.text = screenTitle;
    navigationTitle.textAlignment = NSTextAlignmentCenter;
    return navigationTitle;
}

//Email validations
+(BOOL) IsValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter {
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}

//Helper class for converting date to string
//Parameter: Date
//Return value : String for date

+(NSString *)convertDateToString:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ddMMyyyy_HHmmss"];
    //[dateFormat setDateFormat:[[GeneralDeclaration generalDeclaration] currentUser]];
    return [dateFormat stringFromDate:date];
}

//Converting string to base64 string
//Parameter: String
//Return value : Base64 string

+(NSString *)base64String:(NSString *)str {
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

//This helper class method to get cutomized back button
//Parameter: Parentview controller
//Return value : Bar button with back arrow and target
//Steps to add : Call this method with viewcontroller and add target method in that view

+(UIBarButtonItem *)getBackButton:(UIViewController *)parentViewController {
    // Custom Back Button
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(17, 10, 60, 18)];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];

    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [backButton setTitleColor:[UIColor colorWithRed:96/255.0f green:96/255.0f blue:96/255.0f alpha:1.0f] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(-12, 0, 10, 18)];
    img.image = [UIImage imageNamed:@"back"];
    [backButton addSubview:img];
    
    [backButton addTarget:parentViewController action:@selector(pushback_click :) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    return backBarButtonItem;
}

+(UIColor *)GetImageBackroundColor {
    UIColor *color = [UIColor blackColor];
    return color;
}

//This class method to encode url
+(NSString *)urlEncodedString:(NSString*)stringToEncode {
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                     (CFStringRef)stringToEncode,
                                                                     NULL,
                                                                     (CFStringRef)@":/?@!$&'()*+,;=",
                                                                     kCFStringEncodingUTF8));
}

//Helper class for converting date to string
//Parameter: Date
//Return value : String for date

+(NSString *)datestringToInsertwithoutzero:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:date];
}


+(void)RemoveBackupAttributeFromFilesInDocumentDirectory {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths objectAtIndex:0];
    NSURL *directoryURL = [NSURL fileURLWithPath:documentPath];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             return YES;
                                         }];
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
        }
        else {
            if (&NSURLIsExcludedFromBackupKey == nil)
                [self addSkipBackupAttributeToItemAtURLForOldiOS:url];
            else
                [self addSkipBackupAttributeToItemAtURL:url];
        }
    }
}

+(BOOL)addSkipBackupAttributeToItemAtURLForOldiOS:(NSURL *)URL {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (NSMutableDictionary *)ParseFacebookPermissions:(id)fbPermissions {
    NSArray *permissionArray = [(NSDictionary*)fbPermissions objectForKey:@"data"];
    NSMutableDictionary *facebookPermissions = [[NSMutableDictionary alloc] init];
    for (int i=0; i < [permissionArray count]; i++)
    {
        NSString *key = [[permissionArray objectAtIndex:i] objectForKey:@"permission"];
        NSString *value = [[permissionArray objectAtIndex:i] objectForKey:@"status"];
        [facebookPermissions setValue:value forKey:key];
    }
    return facebookPermissions;
}

@end