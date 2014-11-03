
#import "ImageCropperView.h"
#import <QuartzCore/QuartzCore.h>
#include <math.h>
#import "UIImage+fixOrientation.h"

@interface ImageCropperView() {
    @private
    CGSize _originalImageViewSize;
    UIImage *originalImage;
}

@end

@implementation ImageCropperView

@synthesize imageView;

-(void)setup:(UIImage*)imageToCrop {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    //UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    //[imageView addGestureRecognizer:rotateGes];
    UIPinchGestureRecognizer *scaleGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [imageView addGestureRecognizer:scaleGes];
    UIPanGestureRecognizer *moveGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [moveGes setMinimumNumberOfTouches:1];
    [moveGes setMaximumNumberOfTouches:1];
    [imageView addGestureRecognizer:moveGes];
    float _imageScale = self.frame.size.width / imageToCrop.size.width;
    imageView.frame = CGRectMake(0, 0, imageToCrop.size.width*_imageScale, imageToCrop.size.height*_imageScale);
    _originalImageViewSize = CGSizeMake(imageToCrop.size.width*_imageScale, imageToCrop.size.height*_imageScale);
    imageView.image = imageToCrop;
    
    originalImage = imageToCrop;
    imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

float _lastTransX = 0.0, _lastTransY = 0.0;
-(void)moveImage:(UIPanGestureRecognizer *)sender {
    @try {
        CGPoint translatedPoint = [sender translationInView:self];
        if([sender state] == UIGestureRecognizerStateBegan) {
            _lastTransX = 0.0;
            _lastTransY = 0.0;
        }
        CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - _lastTransX, translatedPoint.y - _lastTransY);
        CGAffineTransform newTransform = CGAffineTransformConcat(imageView.transform, trans);
        _lastTransX = translatedPoint.x;
        _lastTransY = translatedPoint.y;
        imageView.transform = newTransform;
        if ([sender state] == UIGestureRecognizerStateEnded) {
            if (_lastScale == 1.0 && (imageView.layer.frame.size.height < self.frame.size.height))
                [self reset];
            else{
                float xPos = imageView.layer.frame.origin.x;
                float yPos = imageView.layer.frame.origin.y;
                if (imageView.layer.frame.origin.x > 0)
                    xPos = 0;
                if (imageView.layer.frame.origin.x < ((imageView.layer.frame.size.width - [HelperMethod GetDeviceWidth]) * -1)) {
                    xPos = (imageView.layer.frame.size.width - [HelperMethod GetDeviceWidth]) * -1;
                }
                if (imageView.layer.frame.origin.y > 0)
                    yPos = 0;
                if (imageView.layer.frame.origin.y < ((imageView.layer.frame.size.height - [HelperMethod GetDeviceWidth] * 4/3)* -1)) {
                    yPos = (imageView.layer.frame.size.height - [HelperMethod GetDeviceWidth] * 4/3)* -1;
                }
                imageView.frame = CGRectMake(xPos, yPos, imageView.frame.size.width, imageView.frame.size.height);
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Move Image Crash");
    }
    @finally {
    }
}

float _lastScale = 1.0;
CGAffineTransform maximumTransform;
-(void)scaleImage:(UIPinchGestureRecognizer *)sender {
    @try {
        if([sender state] == UIGestureRecognizerStateBegan) {
            _lastScale = 1.0;
            return;
        }
        
        CGFloat scale = [sender scale]/_lastScale;
        CGAffineTransform currentTransform = imageView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
        [imageView setTransform:newTransform];
        _lastScale = [sender scale];

        CGFloat actualTransformScale = [[imageView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
        if(actualTransformScale < 3.0)
            maximumTransform = CGAffineTransformScale(newTransform, 1.0, 1.0);;
        if([sender state] == UIGestureRecognizerStateEnded)
        {
            if (actualTransformScale < 1)
                [self reset];
            if(actualTransformScale > 3.0)
            {
                [imageView setTransform:maximumTransform];
                _lastScale = [sender scale];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Scale Image Crash");
    }
    @finally {
    }
}

float _lastRotation = 0.0;
-(void)rotateImage:(UIRotationGestureRecognizer *)sender {
    if([sender state] == UIGestureRecognizerStateEnded) {
        _lastRotation = 0.0;
        return;
    }
    CGFloat rotation = -_lastRotation + [sender rotation];
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [imageView setTransform:newTransform];
    _lastRotation = [sender rotation];
}

-(UIImage*)finishCropping {
    float zoomScale = [[imageView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
    float rotate = [[imageView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
    float _imageScale = originalImage.size.width/_originalImageViewSize.width;
    CGSize cropSize = CGSizeMake(self.frame.size.width/zoomScale, self.frame.size.height/zoomScale);
    CGPoint cropperViewOrigin = CGPointMake((0.0 - imageView.frame.origin.x)/zoomScale,
                                            (0.0 - imageView.frame.origin.y)/zoomScale);
    if((NSInteger)cropSize.width % 2 == 1)
        cropSize.width = ceil(cropSize.width);
    if((NSInteger)cropSize.height % 2 == 1)
        cropSize.height = ceil(cropSize.height);
    CGRect CropRectinImage = CGRectMake((NSInteger)(cropperViewOrigin.x*_imageScale) ,(NSInteger)( cropperViewOrigin.y*_imageScale), (NSInteger)(cropSize.width*_imageScale),(NSInteger)(cropSize.height*_imageScale));
    UIImage *rotInputImage = [originalImage imageRotatedByRadians:rotate];
    CGImageRef tmp = CGImageCreateWithImageInRect([rotInputImage CGImage], CropRectinImage);
    UIImage *croppedImage = [UIImage imageWithCGImage:tmp scale:originalImage.scale orientation:originalImage.imageOrientation];
    CGImageRelease(tmp);
    return croppedImage;
}

-(void)reset {
    _lastScale = 1.0;
    _lastTransX = 0.0;
    _lastTransY = 0.0;
    imageView.transform = CGAffineTransformIdentity;
    imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

-(void)dealloc {
	imageView = nil;
}
@end