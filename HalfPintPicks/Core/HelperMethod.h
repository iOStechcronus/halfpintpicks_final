//
//  HelperMethod.h


#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "GeneralDeclaration.h"

@interface HelperMethod : NSObject

+(NSString *) GetCurrentCulture;
+(NSString *) GetLocalizeTextForKey:(NSString *)key;
+(BOOL)CheckInternetStatus;
+(NSString *) GetWebAPIBasePath;
+(BOOL) IsDeviceiPhone;
+(CGFloat) GetDeviceWidth;
+(CGFloat) GetDeviceHeight;
+(NSString *) GetStoryBoardName;
+(BOOL) IsValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter;
+(NSString *)convertDateToString:(NSDate*)date;
+(NSString *)base64String:(NSString *)str;
+(UILabel * ) GetNavigationTitle:(NSString *)screenTitle ;
+(UIBarButtonItem *)getBackButton:(UIViewController *)parentViewController;
+(UIColor *)GetImageBackroundColor;
+(NSString *)urlEncodedString:(NSString*)stringToEncode;
+(NSString *)datestringToInsertwithoutzero:(NSDate *)date;
+(void)RemoveBackupAttributeFromFilesInDocumentDirectory;
+(BOOL)addSkipBackupAttributeToItemAtURLForOldiOS:(NSURL *)URL;
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+(NSMutableDictionary *)ParseFacebookPermissions:(id)fbPermissions;
@end
