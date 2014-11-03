//
//  AKMeme.h


#import <Foundation/Foundation.h>
#import "AKLookups.h"

@interface AKMeme : NSObject <AKLookupsCapableItem>
@property (nonatomic, strong) NSString* lookupTitle;
@property (nonatomic, strong) NSString* imageName;
+(AKMeme*)memeWithTitle:(NSString*)title imageName:(NSString*)imageName;
@end
