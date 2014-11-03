//
//  ItemCategory.h
//  HalfPintPicks
//
//  Copyright (c) 2013 TechCronus. All rights reserved.
//
// This class is for Category of item

#import <Foundation/Foundation.h>

@interface ItemCategory : NSObject

@property int CategoryId, SubcategoryId, Status, created_by, updated_by;
@property (nonatomic, retain) NSString *Name ;

@end
