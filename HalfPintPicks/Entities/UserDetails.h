//
//  UserDetails.h
//  HalfPintPicks
//
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetails : NSObject

@property int UserId, ScreenWidth, ScreenHeigth, ContactId, UserType, UserRights,TotalRecords, TotalPages, PortalId, CountryId, LoginHistoryId, ReferredBy, PageSize, PageNumber, FollowinUserId,TotalMyFollowingCount,TotalMyFollowersCount,ProfileViewCount, AddressId;

@property double WalletBalance;

@property (nonatomic, retain) NSDate *DOB, *CreatedDate, *UpdatedDate, *BirthDate;

@property (nonatomic, retain) NSString *FirstName, *LastName, *Email, *Password, *UserName, *stripeId, *LoggedInUserFullName , *ActiveImage, *ResetPasswordImage, *UserRightsText, *SortExpression, *SortDirection, *Salutation, *Source, *PortalName, *TooltipForActiveInActiveCustomer, *Address1, *Address2, *City, *ProfileImageName, *FacebookLogInImage, *FacebookUserId, *Telephone, *zipcode, *Country, *State, *CustomerRegistrationDate, *locale, *name, *UserPlatform , *NewUserRegistrationMessage, *gender, *culture, *Newpassword, *shoeSize, *clothSize, *ItemDetailBaseURL, *FtpUrl, *FtpUserName, *FtpPassword, *OldPassword, *Residence, *BirthDateString, *JeansSize, *BeltSize, *CompanyName, *hometown ,*coverImage;

@property BOOL IsActive, IsInvitedUser, IsFacebookLogin, IsValidUser, IsUserFollowOtherUser, IsPasswordChange, IsApplyInFilter;


@end
