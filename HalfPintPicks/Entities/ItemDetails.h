//
//  ItemDetails.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/11/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemDetails : NSObject

@property int ItemId, BoutiqueId, SizeId, InventoryId, Quantity, DesignerId, SellerUserId, TotalUserItemLikeCount, TotalUserItemCommentCount, CategoryId, SubCategoryId, ColorThemeId, SizeGroupId ,BoutiquesId, TotalMyFollowersCount, ProfileViewCount, TotalMyFollowingCount, TotalItemCount, SellerItemId;

@property (nonatomic, assign) double ItemSpecialPrice,  PriceInDecimal, SpecialPriceInDecimal, DiscountInDecimal, Commision, ItemCondition,OriginalPriceDec,UserEarningPrice;

@property (nonatomic, assign) int ItemPrice ;
@property (nonatomic, retain) NSDate  *CreatedDate, *UpdatedDate ;

@property (nonatomic, retain) NSString *ItemNo, *BoutiqueName, *Size, *Email, *Name, *Address, *Country, *Phone , *State, *Description, *CompanyName, *CompanyOwner, *Street, *City, *Contact, *PostalCode, *Discount, *Designer, *Price, *SpecialPrice, *DesignerName, *ItemDescription, *SpecialPriceWithDiscount, *StoreUrlKey, *Sku, *StoreItemNo, *SmallImageName, *MetaTitle, *MetaDescription, *MetaKeyword, *SellerUserName , *SellerUserFirstname,*UserProfileImageName, *ItemCreationDate, *FacebookUserId, *CategoryName, *SubCategoryName, *ColorThemeName, *SizeGroupName, *BoutiquesName, *ItemName, *ItemUrlKey, *ItemFrontImage, *SizeName,*OriginalPrice,*UserCity,*UserCountry, *FacebookShareUrl;

@property BOOL AlreadyItemInCart, IsDiscountApply, IsAvailOnPhone, IsFacebookLogin, ShowOnTop, ItemLikeStatus, IsItemReserved ;

@end
