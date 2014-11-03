//
//  AKMeme.m


#import "AKMeme.h"

@implementation AKMeme
+(AKMeme*)memeWithTitle:(NSString*)title imageName:(NSString*)imageName
{
	AKMeme* carModel = [AKMeme new];
	carModel.lookupTitle = title;
	carModel.imageName = imageName;
	return carModel;
}
@end
