//
//  JSONParser.h
//  HalfPintPicks
//
//  Created by Vandan.Javiya on 03/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelperMethod.h"
#import "UserDetails.h"
#import "ItemCategory.h"
#import "SizeGroup.h"
#import "ItemBrand.h"
#import "KidDetails.h"

@interface JSONParser : NSObject

//Function for parsing userdata received from web services
+(UserDetails *) ParseUserInfoFromJSONData:(NSDictionary *)userDictionary ;

//Function for parsing userdata received from Faceboook servers
+ (UserDetails *)ParseUserInfoFromFbJsonData:(NSDictionary *)userDictionary;

//Function for parsing Item categories received from web services
+ (NSMutableArray *) ParseItemCategoryFromJsonData:(NSDictionary *)itemCategoryDictionary ;

//Function for parsing Sizes of item received from web services
+(NSMutableArray *) ParseSizeGroupFromJsonData:(NSDictionary *)sizeGroupDictionary;

//Function for parsing Brand of item received from web services
+(NSMutableArray *) ParseBrandDetailsFromJsonData:(NSDictionary *)brandDictionary;

//Function for parsing Kid details received from web service
+(NSMutableArray *) ParseKidsDataFromJsonData:(NSDictionary *)kidsDictionary;

//Function for parsing Item Details received from web services
+(NSMutableArray *) ParseItemBoutiqueFromJsonData:(NSDictionary *)itemBoutiqueDictionary;

@end
