//  HalfPintPicks
//
//
//  Copyright (c) 2013 TechCronus. All rights reserved.
//
// This class is for item brand 

#import <Foundation/Foundation.h>

@interface ItemBrand : NSObject

@property int CategoryId, BrandId, Status, created_by, updated_by;
@property (nonatomic, retain) NSString *Name;

@end
