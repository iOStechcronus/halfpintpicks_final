//
//  KidDetails.h
//  HalfPintPicks
//
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KidDetails : NSObject

@property int KidId, ParentId, ClothSizeId, ShoeSiezId, Age,Status, created_by, updated_by;;

@property BOOL IsDefault,Gender;

@property (nonatomic, retain) NSString *FullName, *ShoeSize, *ClothSize, *ProfileImage ;
@end
