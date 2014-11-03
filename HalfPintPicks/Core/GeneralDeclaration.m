//
//  GeneralDeclaration.m


#import "GeneralDeclaration.h"
#import "HelperMethod.h"

@implementation GeneralDeclaration

@synthesize isiPhone = _isiPhone;
@synthesize screenHeight = _screenHeight;
@synthesize screenWidth = _screenWidth;
@synthesize iOS7 = _iOS7;
@synthesize currentScreen = _currentScreen;
@synthesize deviceToken = _deviceToken;
@synthesize isPushNotificationOn = _isPushNotificationOn;
@synthesize isNewUser = _isNewUser;
@synthesize isScroll = _isScroll;
@synthesize HeightForImage;
@synthesize previouScreen = _previouScreen;

+(GeneralDeclaration*)generalDeclaration {
    static dispatch_once_t pred;
    static GeneralDeclaration *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[GeneralDeclaration alloc] init];
        shared.isiPhone = [HelperMethod IsDeviceiPhone];
        shared.screenWidth = shared.isiPhone == YES ? 320.0 : 768.0;
        shared.screenHeight = [[UIScreen mainScreen] bounds].size.height;
        shared.storyBoardName = [HelperMethod IsDeviceiPhone] == YES ? @"Main_iPhone" : @"Main_iPad";
        shared.iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? YES : NO;
        //NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       // NSString *documentsDir = [documentPaths objectAtIndex:0];
        shared.currentScreen = @"";
        shared.isPushNotificationOn = true;
        shared.deviceToken = @"";
        shared.isNewUser = false;
        shared.isScroll = FALSE;
        shared.HeightForImage = 0;
        shared.previouScreen = @"";
    });
    return shared;
}
@end