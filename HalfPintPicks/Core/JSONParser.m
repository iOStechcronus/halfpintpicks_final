//
//  JSONParser.m
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 03/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

//This is parsing method for Facebook Data.
+ (UserDetails *)ParseUserInfoFromFbJsonData:(NSDictionary *)userDictionary {
    UserDetails *userInfo = [[UserDetails alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    @try {
        
        if([userDictionary objectForKey:@"first_name"] != [NSNull null])
            userInfo.FirstName = (NSString *) [userDictionary objectForKey:@"first_name"];
        
        if([userDictionary objectForKey:@"last_name"] != [NSNull null])
            userInfo.LastName = (NSString *) [userDictionary objectForKey:@"last_name"];
        
        if([userDictionary objectForKey:@"email"] != [NSNull null])
            userInfo.Email = (NSString *) [userDictionary objectForKey:@"email"];
        
        if([userDictionary objectForKey:@"gender"] != [NSNull null])
            userInfo.gender = (NSString *) [userDictionary objectForKey:@"gender"];
        
        if([userDictionary objectForKey:@"username"] != [NSNull null])
            userInfo.UserName = (NSString *) [userDictionary objectForKey:@"username"];
        
        if([userDictionary objectForKey:@"id"] != [NSNull null])
            userInfo.FacebookUserId = (NSString *) [userDictionary objectForKey:@"id"];
        
        userInfo.ProfileImageName = [(NSString *) [userDictionary objectForKey:@"username"] stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        
        if([userDictionary objectForKey:@"birthday"] != [NSNull null])
            userInfo.BirthDate = [dateFormat dateFromString:(NSString *) [userDictionary objectForKey:@"birthday"]];
        
        if ([userDictionary objectForKey:@"location"] != [NSNull null])
            userInfo.hometown = (NSString *) [[userDictionary objectForKey:@"location"] objectForKey:@"name"];

        userInfo.IsFacebookLogin = YES;
        userInfo.UserPlatform = @"iOS";
    }
    @catch (NSException *exception) {
        NSLog(@"Exception:-%@", [exception description]);
    }
    @finally {
        return userInfo;
    }
}

+(UserDetails *) ParseUserInfoFromJSONData:(NSDictionary *)userDictionary {
    UserDetails *userInfo = [[UserDetails alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
    @try {
        
        if([userDictionary objectForKey:@"firstname"] != [NSNull null])
            userInfo.FirstName = (NSString *) [userDictionary objectForKey:@"firstname"];
        
        if([userDictionary objectForKey:@"lastname"] != [NSNull null])
            userInfo.LastName = (NSString *) [userDictionary objectForKey:@"lastname"];
        
        if([userDictionary objectForKey:@"email"] != [NSNull null])
            userInfo.Email = (NSString *) [userDictionary objectForKey:@"email"];
        
        if([userDictionary objectForKey:@"password"] != [NSNull null])
            userInfo.Password = (NSString *) [userDictionary objectForKey:@"password"];
        
        if([userDictionary objectForKey:@"user_id"] != [NSNull null])
            userInfo.UserId = [[userDictionary objectForKey:@"user_id"] intValue];
        
        
        if([userDictionary objectForKey:@"folllowers"] != [NSNull null])
            userInfo.TotalMyFollowersCount = [[userDictionary objectForKey:@"folllowers"] intValue];
        
        if([userDictionary objectForKey:@"follow_to"] != [NSNull null])
            userInfo.TotalMyFollowingCount = [[userDictionary objectForKey:@"follow_to"] intValue];
        
        userInfo.TotalRecords = [[userDictionary objectForKey:@"TotalRecords"] intValue];
  
        userInfo.TotalPages = [[userDictionary objectForKey:@"TotalPages"] intValue];
        
        if([userDictionary objectForKey:@"activation_status"] != [NSNull null])
            userInfo.IsActive = [[userDictionary objectForKey:@"activation_status"] intValue];
        
        if([userDictionary objectForKey:@"IsFacebookLogin"] != [NSNull null])
            userInfo.IsFacebookLogin = [[userDictionary objectForKey:@"IsFacebookLogin"] intValue];
        
        if([userDictionary objectForKey:@"IsValidUser"] != [NSNull null])
            userInfo.IsValidUser = [[userDictionary objectForKey:@"IsValidUser"] intValue];
        
        if([userDictionary objectForKey:@"UserName"] != [NSNull null])
            userInfo.UserName = (NSString *) [userDictionary objectForKey:@"UserName"];
        
        if([userDictionary objectForKey:@"Telephone"] != [NSNull null])
            userInfo.Telephone = (NSString *) [userDictionary objectForKey:@"Telephone"];
        
        if([userDictionary objectForKey:@"zipcode"] != [NSNull null])
            userInfo.zipcode = (NSString *) [userDictionary objectForKey:@"zipcode"];
        
        if([userDictionary objectForKey:@"country"] != [NSNull null])
            userInfo.Country = (NSString *) [userDictionary objectForKey:@"country"];
        
        if([userDictionary objectForKey:@"state"] != [NSNull null])
            userInfo.State = (NSString *) [userDictionary objectForKey:@"state"];
        
        if([userDictionary objectForKey:@"address"] != [NSNull null])
            userInfo.Address1 = (NSString *) [userDictionary objectForKey:@"address"];
        
        if([userDictionary objectForKey:@"Address2"] != [NSNull null])
            userInfo.Address2 = (NSString *) [userDictionary objectForKey:@"Address2"];
        
        if([userDictionary objectForKey:@"city"] != [NSNull null])
            userInfo.City = (NSString *) [userDictionary objectForKey:@"city"];
        
        if([userDictionary objectForKey:@"profile_image"] != [NSNull null])
            userInfo.ProfileImageName = (NSString *) [userDictionary objectForKey:@"profile_image"];
        
        if([userDictionary objectForKey:@"cover_image"] != [NSNull null])
            userInfo.coverImage = (NSString *) [userDictionary objectForKey:@"cover_image"];
        
        if([userDictionary objectForKey:@"FacebookLogInImage"] != [NSNull null])
            userInfo.FacebookLogInImage = (NSString *) [userDictionary objectForKey:@"FacebookLogInImage"];
        
        if([userDictionary objectForKey:@"FacebookUserId"] != [NSNull null])
            userInfo.FacebookUserId = (NSString *) [userDictionary objectForKey:@"FacebookUserId"];
        
        if([userDictionary objectForKey:@"UserId"] != [NSNull null])
            userInfo.FollowinUserId = [[userDictionary objectForKey:@"UserId"] intValue];
        
        if([userDictionary objectForKey:@"IsUserFollowOtherUser"] != [NSNull null])
            userInfo.IsUserFollowOtherUser = [[userDictionary objectForKey:@"IsUserFollowOtherUser"] intValue];
        
        if([userDictionary objectForKey:@"stripe_id"] != [NSNull null])
            userInfo.stripeId = (NSString *) [userDictionary objectForKey:@"stripe_id"];
        
        if([userDictionary objectForKey:@"BirthDateString"] != [NSNull null])
            userInfo.BirthDateString = (NSString *) [userDictionary objectForKey:@"BirthDateString"];
        
        NSRange subStringRange = NSMakeRange(0, 19);
        if([userDictionary objectForKey:@"DOB"] != [NSNull null])
            userInfo.DOB = [dateFormat dateFromString:(NSString *) [userDictionary objectForKey:@"DOB"]];
        if([userDictionary objectForKey:@"created"] != [NSNull null])
            userInfo.CreatedDate = [dateFormat dateFromString:[(NSString *) [userDictionary objectForKey:@"created"] substringWithRange:subStringRange]];
        if([userDictionary objectForKey:@"modified"] != [NSNull null])
            userInfo.UpdatedDate = [dateFormat dateFromString:[(NSString *) [userDictionary objectForKey:@"modified"] substringWithRange:subStringRange]];
        
        if([userDictionary objectForKey:@"BirthDate"] != [NSNull null])
            userInfo.BirthDate = [dateFormat dateFromString:(NSString *) [userDictionary objectForKey:@"BirthDate"]];
        
        if([userDictionary objectForKey:@"AddressId"] != [NSNull null])
            userInfo.AddressId = [[userDictionary objectForKey:@"AddressId"] intValue];
        
        
    }
    @catch (NSException *exception) {
    }
    @finally {
        return userInfo;
    }
}


+(NSMutableArray *) ParseItemBoutiqueFromJsonData:(NSDictionary *)itemBoutiqueDictionary {
    NSMutableArray *itemBoutiqueDetailsList = [[NSMutableArray alloc] init];
    @try {
        for (id obj in itemBoutiqueDictionary)
        {
            ItemDetails *ietmInfo = [[ItemDetails alloc] init];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
            
            if([obj objectForKey:@"ItemId"] != [NSNull null])
                ietmInfo.ItemId = [[obj objectForKey:@"ItemId"] intValue];
            
            if([obj objectForKey:@"SizeId"] != [NSNull null])
                ietmInfo.SizeId = [[obj objectForKey:@"SizeId"] intValue];
            
            if([obj objectForKey:@"BoutiqueId"] != [NSNull null])
                ietmInfo.BoutiqueId = [[obj objectForKey:@"BoutiqueId"] intValue];
            
            if([obj objectForKey:@"InventoryId"] != [NSNull null])
                ietmInfo.InventoryId = [[obj objectForKey:@"InventoryId"] intValue];
            
            if([obj objectForKey:@"Quantity"] != [NSNull null])
                ietmInfo.Quantity = [[obj objectForKey:@"Quantity"] intValue];
            
            ietmInfo.DesignerId = [[obj objectForKey:@"DesignerId"] intValue];
            ietmInfo.SellerUserId = [[obj objectForKey:@"SellerUserId"] intValue];
            
            if([obj objectForKey:@"TotalUserItemLikeCount"] != [NSNull null])
                ietmInfo.TotalUserItemLikeCount = [[obj objectForKey:@"TotalUserItemLikeCount"] intValue];
            
            if([obj objectForKey:@"TotalUserItemCommentCount"] != [NSNull null])
                ietmInfo.TotalUserItemCommentCount = [[obj objectForKey:@"TotalUserItemCommentCount"] intValue];
            
            if([obj objectForKey:@"CategoryId"] != [NSNull null])
                ietmInfo.CategoryId = [[obj objectForKey:@"CategoryId"] intValue];
            
            if([obj objectForKey:@"SubCategoryId"] != [NSNull null])
                ietmInfo.SubCategoryId = [[obj objectForKey:@"SubCategoryId"] intValue];
            if([obj objectForKey:@"SizeGroupId"] != [NSNull null])
                ietmInfo.SizeGroupId = [[obj objectForKey:@"SizeGroupId"] intValue];
            if([obj objectForKey:@"BoutiquesId"] != [NSNull null])
                ietmInfo.BoutiquesId = [[obj objectForKey:@"BoutiquesId"] intValue];
            
            if([obj objectForKey:@"ItemLikeStatus"] != [NSNull null])
                ietmInfo.ItemLikeStatus = [[obj objectForKey:@"ItemLikeStatus"] intValue];
            
            if([obj objectForKey:@"IsItemReserved"] != [NSNull null])
                ietmInfo.IsItemReserved = [[obj objectForKey:@"IsItemReserved"] intValue];
            
            
            if([obj objectForKey:@"ItemSpecialPrice"] != [NSNull null])
                ietmInfo.ItemSpecialPrice = [[obj objectForKey:@"ItemSpecialPrice"] doubleValue];
            if([obj objectForKey:@"ItemPrice"] != [NSNull null])
                ietmInfo.ItemPrice = [[obj objectForKey:@"ItemPrice"] doubleValue];
            if([obj objectForKey:@"PriceInDecimal"] != [NSNull null])
                ietmInfo.PriceInDecimal = [[obj objectForKey:@"PriceInDecimal"] doubleValue];
            if([obj objectForKey:@"OriginalPriceDec"] != [NSNull null])
                ietmInfo.OriginalPriceDec = [[obj objectForKey:@"OriginalPriceDec"] doubleValue];
            if([obj objectForKey:@"SpecialPriceInDecimal"] != [NSNull null])
                ietmInfo.SpecialPriceInDecimal = [[obj objectForKey:@"SpecialPriceInDecimal"] doubleValue];
            if([obj objectForKey:@"DiscountInDecimal"] != [NSNull null])
                ietmInfo.DiscountInDecimal = [[obj objectForKey:@"DiscountInDecimal"] doubleValue];
            if([obj objectForKey:@"Commision"] != [NSNull null])
                ietmInfo.Commision = [[obj objectForKey:@"Commision"] doubleValue];
            if([obj objectForKey:@"ItemCondition"] != [NSNull null])
                ietmInfo.ItemCondition = [[obj objectForKey:@"ItemCondition"] doubleValue];
            
            if([obj objectForKey:@"Size"] != [NSNull null])
                ietmInfo.Size = (NSString *) [obj objectForKey:@"Size"];
            if([obj objectForKey:@"Discount"] != [NSNull null])
                ietmInfo.Discount= (NSString *) [obj objectForKey:@"Discount"];
            if([obj objectForKey:@"Designer"] != [NSNull null])
                ietmInfo.Designer= (NSString *) [obj objectForKey:@"Designer"];
            if([obj objectForKey:@"Price"] != [NSNull null])
                ietmInfo.Price= (NSString *) [obj objectForKey:@"Price"];
            if([obj objectForKey:@"SpecialPrice"] != [NSNull null])
                ietmInfo.SpecialPrice= (NSString *) [obj objectForKey:@"SpecialPrice"];
            
            if([obj objectForKey:@"OriginalPrice"] != [NSNull null])
                ietmInfo.OriginalPrice= (NSString *) [obj objectForKey:@"OriginalPrice"];
            
            if([obj objectForKey:@"DesignerName"] != [NSNull null])
                ietmInfo.DesignerName= (NSString *) [obj objectForKey:@"DesignerName"];
            if([obj objectForKey:@"ItemDescription"] != [NSNull null])
                ietmInfo.ItemDescription= (NSString *) [obj objectForKey:@"ItemDescription"];
            if([obj objectForKey:@"SpecialPriceWithDiscount"] != [NSNull null])
                ietmInfo.SpecialPriceWithDiscount= (NSString *) [obj objectForKey:@"SpecialPriceWithDiscount"];
            if([obj objectForKey:@"SmallImageName"] != [NSNull null])
                ietmInfo.SmallImageName= (NSString *) [obj objectForKey:@"SmallImageName"];
            if([obj objectForKey:@"ItemCreationDate"] != [NSNull null])
                ietmInfo.ItemCreationDate= (NSString *) [obj objectForKey:@"ItemCreationDate"];
            if([obj objectForKey:@"ItemFrontImage"] != [NSNull null])
                ietmInfo.ItemFrontImage= (NSString *) [obj objectForKey:@"ItemFrontImage"];
            if([obj objectForKey:@"SizeName"] != [NSNull null])
                ietmInfo.SizeName = (NSString *) [obj objectForKey:@"SizeName"];
            if([obj objectForKey:@"TotalItemCount"] != [NSNull null])
                ietmInfo.TotalItemCount = [[obj objectForKey:@"TotalItemCount"] intValue];
            if([obj objectForKey:@"UserEarningPrice"] != [NSNull null])
                ietmInfo.UserEarningPrice = [[obj objectForKey:@"UserEarningPrice"] doubleValue];
            
            NSRange subStringRange = NSMakeRange(0, 19);
            
            if([obj objectForKey:@"CreatedDate"] != [NSNull null])
                ietmInfo. CreatedDate = [dateFormat dateFromString:[(NSString *) [obj objectForKey:@"CreatedDate"] substringWithRange:subStringRange]];
            if([obj objectForKey:@"UpdatedDate"] != [NSNull null])
                ietmInfo.UpdatedDate = [dateFormat dateFromString:[(NSString *) [obj objectForKey:@"UpdatedDate"] substringWithRange:subStringRange]];
            
            [itemBoutiqueDetailsList addObject:ietmInfo];
            
        }
    }
    
    @catch (NSException *exception) {
    }
    @finally {
        return itemBoutiqueDetailsList;
    }
}

+(NSMutableArray *) ParseItemCategoryFromJsonData:(NSDictionary *)itemCategoryDictionary {
    NSMutableArray *itemCategoryDataList = [[NSMutableArray alloc] init];
    @try {
        for (id obj in itemCategoryDictionary)
        {
            ItemCategory *category = [[ItemCategory alloc] init];
            if ([obj objectForKey:@"id"] != [NSNull null])
                category.CategoryId = [[obj objectForKey:@"id"] intValue];
            if ([obj objectForKey:@"category_id"] != [NSNull null])
                category.SubcategoryId = [[obj objectForKey:@"category_id"] intValue];
            if ([obj objectForKey:@"status"] != [NSNull null])
                category.Status = [[obj objectForKey:@"status"] intValue];
            if ([obj objectForKey:@"created_by"] != [NSNull null])
                category.created_by = [[obj objectForKey:@"created_by"] intValue];
            if ([obj objectForKey:@"modified_by"] != [NSNull null])
                category.updated_by = [[obj objectForKey:@"modified_by"] intValue];
            if ([obj objectForKey:@"name"] != [NSNull null])
                category.Name = (NSString *) [obj objectForKey:@"name"];

            
            [itemCategoryDataList addObject:category];
        }
    }
    
    @catch (NSException *exception) {
    }
    @finally {
        return itemCategoryDataList;
    }
}

+(NSMutableArray *) ParseSizeGroupFromJsonData:(NSDictionary *)sizeGroupDictionary {
    NSMutableArray *sizeGroupList = [[NSMutableArray alloc] init];
    @try {
        for (id obj in sizeGroupDictionary)
        {
            SizeGroup *sizeGroup = [[SizeGroup alloc] init];
            if ([obj objectForKey:@"id"] != [NSNull null])
                sizeGroup.Id = [[obj objectForKey:@"id"] intValue];
            if ([obj objectForKey:@"category_id"] != [NSNull null])
                sizeGroup.CategoryId = [[obj objectForKey:@"category_id"] intValue];
            if ([obj objectForKey:@"status"] != [NSNull null])
                sizeGroup.Status = [[obj objectForKey:@"status"] intValue];
            if ([obj objectForKey:@"created_by"] != [NSNull null])
                sizeGroup.created_by = [[obj objectForKey:@"created_by"] intValue];
            if ([obj objectForKey:@"modified_by"] != [NSNull null])
                sizeGroup.updated_by = [[obj objectForKey:@"modified_by"] intValue];
            if ([obj objectForKey:@"name"] != [NSNull null])
                sizeGroup.Name = (NSString *) [obj objectForKey:@"name"];
            [sizeGroupList addObject:sizeGroup];
        }
    }
    
    @catch (NSException *exception) {
    }
    @finally {
        return sizeGroupList;
    }
}

+(NSMutableArray *) ParseBrandDetailsFromJsonData:(NSDictionary *)brandDictionary {
    NSMutableArray *brandList = [[NSMutableArray alloc] init];
    @try {
        for (id obj in brandDictionary)
        {
            
            ItemBrand *brand =[[ItemBrand alloc]init];
            if ([obj objectForKey:@"id"] != [NSNull null])
                brand.BrandId = [[obj objectForKey:@"id"] intValue];
            if ([obj objectForKey:@"category_id"] != [NSNull null])
                brand.CategoryId = [[obj objectForKey:@"category_id"] intValue];
            if ([obj objectForKey:@"status"] != [NSNull null])
                brand.Status = [[obj objectForKey:@"status"] intValue];
            if ([obj objectForKey:@"created_by"] != [NSNull null])
                brand.created_by = [[obj objectForKey:@"created_by"] intValue];
            if ([obj objectForKey:@"modified_by"] != [NSNull null])
                brand.updated_by = [[obj objectForKey:@"modified_by"] intValue];
            if ([obj objectForKey:@"name"] != [NSNull null])
                brand.Name = (NSString *) [obj objectForKey:@"name"];
            
            [brandList addObject:brand];
        }
    }
    
    @catch (NSException *exception) {
    }
    @finally {
        return brandList;
    }
}

+(NSMutableArray *) ParseKidsDataFromJsonData:(NSDictionary *)kidsDictionary {
    NSMutableArray *kidsList = [[NSMutableArray alloc] init];
    @try {
        for (id obj in kidsDictionary)
        {
            
            KidDetails *kidsInfo =[[KidDetails alloc]init];
            if ([obj objectForKey:@"id"] != [NSNull null])
                kidsInfo.KidId = [[obj objectForKey:@"id"] intValue];
            if ([obj objectForKey:@"parent_id"] != [NSNull null])
                kidsInfo.ParentId = [[obj objectForKey:@"parent_id"] intValue];
            if ([obj objectForKey:@"age"] != [NSNull null])
                kidsInfo.Age = [[obj objectForKey:@"age"] intValue];
            if ([obj objectForKey:@"name"] != [NSNull null])
                kidsInfo.FullName = (NSString *) [obj objectForKey:@"name"];
            if ([obj objectForKey:@"image"] != [NSNull null])
                kidsInfo.ProfileImage = (NSString *) [obj objectForKey:@"image"];
            if ([obj objectForKey:@"status"] != [NSNull null])
                kidsInfo.Status = [[obj objectForKey:@"status"] intValue];
            if ([obj objectForKey:@"created_by"] != [NSNull null])
                kidsInfo.created_by = [[obj objectForKey:@"created_by"] intValue];
            if ([obj objectForKey:@"modified_by"] != [NSNull null])
                kidsInfo.updated_by = [[obj objectForKey:@"modified_by"] intValue];
            if ([obj objectForKey:@"cloth_size"] != [NSNull null])
                kidsInfo.ClothSizeId = [[obj objectForKey:@"cloth_size"] intValue];
            if ([obj objectForKey:@"shoes_size"] != [NSNull null])
                kidsInfo.ShoeSiezId = [[obj objectForKey:@"shoes_size"] intValue];
            if ([obj objectForKey:@"gender"] != [NSNull null])
                kidsInfo.Gender = [[obj objectForKey:@"gender"] boolValue];
            [kidsList addObject:kidsInfo];
        }
    }
    
    @catch (NSException *exception) {
    }
    @finally {
        return kidsList;
    }
}

@end
