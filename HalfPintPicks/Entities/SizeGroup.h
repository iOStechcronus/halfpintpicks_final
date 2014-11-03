//
//  SizeGroup.h
//  HalfPintPicks
//
//  Copyright (c) 2013 TechCronus. All rights reserved.
//
// This class is for Size if item 

#import <Foundation/Foundation.h>

@interface SizeGroup : NSObject

@property int Id, CategoryId, Status,  created_by, updated_by;
@property (nonatomic, retain) NSString *Name;

@end
