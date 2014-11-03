//
//  ItemPictures.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/12/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemPictures : NSObject

@property int Id, ItemId, Sequence, ImageViewType;
@property (nonatomic, retain) NSString *Name, *Label,*ImageUrl;
@property BOOL IsItemPictureAvailable;
@property  NSData *itemPictureContent;
@property (nonatomic, retain) UIImage* itemPicture;

@end
