
#import <UIKit/UIKit.h>

@protocol ImageCropperDelegate;

@interface ImageCropperView : UIView

@property (nonatomic, retain) UIImageView *imageView;

- (void)setup:(UIImage*)imageToCrop;
- (UIImage*)finishCropping;
- (void)reset;

@end