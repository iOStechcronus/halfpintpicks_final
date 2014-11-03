//
//  UIImage+fixOrientation.h

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)cropImageInFrame:(CGRect)croppingFrame;
- (UIImage *)cropImageForCorrectAspectRatio;
- (UIImage *)scaleImageToNewSize:(CGSize)newImageSize;

@end