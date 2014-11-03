//
//  ImageCropperViewController.h


#import <UIKit/UIKit.h>
#import "ImageCropperView.h"
@protocol ImageCropperDelegate;

@interface ImageCropperViewController : UIViewController
@property (nonatomic, retain) UIImage *imageToCrop;
@property bool isProfilePicture;
@property CGSize imageCropSize;
@property (nonatomic, retain) IBOutlet ImageCropperView *cropperView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cropperHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topMarginForCropper;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topMarginForCancel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topMarginForDone;

@property (nonatomic, retain) IBOutlet UIButton *btnCrop;
@property (nonatomic, retain) IBOutlet UIButton *btnCancel;
- (IBAction)btnCrop_Clicked:(id)sender;
- (IBAction)btnCancel_Clicked:(id)sender;
@property (nonatomic, assign) id <ImageCropperDelegate> delegate;
@end

@protocol ImageCropperDelegate <NSObject>
- (void)imageCropperDidFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel;
@end