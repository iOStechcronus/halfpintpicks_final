//
//  GeneralDeclaration.h


#import <Foundation/Foundation.h>

@interface GeneralDeclaration : NSObject

@property (nonatomic, assign) BOOL isiPhone, iOS7, isPushNotificationOn, isNewUser, isScroll;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, retain) NSString *storyBoardName;
@property (nonatomic, retain) NSString *currentScreen, *previouScreen;
@property (nonatomic, retain) NSString *deviceToken;
@property (nonatomic, assign) CGFloat HeightForImage;
+(GeneralDeclaration*)generalDeclaration;
@end
