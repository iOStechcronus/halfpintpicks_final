//
//  UIImage+fixOrientation.m


#import "UIImage+fixOrientation.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

- (UIImage *)cropImageInFrame:(CGRect)croppingFrame {
    float _imageScale = [HelperMethod GetDeviceWidth] / self.size.width;
    CGSize _originalImageViewSize = CGSizeMake(self.size.width*_imageScale, self.size.height*_imageScale);
    
    _imageScale = self.size.width/_originalImageViewSize.width;
    CGSize cropSize = croppingFrame.size;
    CGPoint cropperViewOrigin = CGPointMake(croppingFrame.origin.x, croppingFrame.origin.y);
    if((NSInteger)cropSize.width % 2 == 1)
        cropSize.width = ceil(cropSize.width);
    if((NSInteger)cropSize.height % 2 == 1)
        cropSize.height = ceil(cropSize.height);
    CGRect CropRectinImage = CGRectMake((NSInteger)(cropperViewOrigin.x*_imageScale) ,(NSInteger)( cropperViewOrigin.y*_imageScale), (NSInteger)(cropSize.width*_imageScale),(NSInteger)(cropSize.height*_imageScale));
    CGImageRef tmp = CGImageCreateWithImageInRect([self CGImage], CropRectinImage);
    UIImage *result = [UIImage imageWithCGImage:tmp scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(tmp);
    return result;
}

- (UIImage *)cropImageForCorrectAspectRatio {
    if((self.size.width * (4.0f/3.0f)) != self.size.height) {
        float newWidth = self.size.width - fmod(self.size.width, 3);
        float newHeight = self.size.width * (4.0f/3.0f);
        CGSize cropSize = CGSizeMake(newWidth, newHeight);
        CGRect CropRectinImage = CGRectMake(0, ((self.size.height/2) - (cropSize.height/2)), (NSInteger)cropSize.width, (NSInteger)cropSize.height);
        CGImageRef tmp = CGImageCreateWithImageInRect([self CGImage], CropRectinImage);
        UIImage *result = [UIImage imageWithCGImage:tmp scale:self.scale orientation:self.imageOrientation];
        CGImageRelease(tmp);
        return result;
    }
    else
        return self;
}

- (UIImage *)scaleImageToNewSize:(CGSize)newImageSize {
    float actualHeight = self.size.height;
    float actualWidth = self.size.width;
    float imgRatio = actualWidth / actualHeight;
    float maxRatio = [HelperMethod GetDeviceWidth] / [HelperMethod GetDeviceHeight];
    
    if(imgRatio!=maxRatio) {
        if(imgRatio < maxRatio){
            imgRatio = newImageSize.height / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = newImageSize.height;
        }
        else{
            imgRatio = newImageSize.width/ actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = newImageSize.width;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end