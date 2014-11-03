//
//  ImageCropperViewController.m


#import "ImageCropperViewController.h"

@interface ImageCropperViewController ()
@end

@implementation ImageCropperViewController
@synthesize cropperView, cropperHeight, btnCrop, btnCancel, delegate, imageToCrop, topMarginForCancel, topMarginForDone, topMarginForCropper, isProfilePicture, imageCropSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    btnCrop.frame=CGRectMake(0,0 ,51 ,26);
    btnCrop.layer.borderColor = [UIColor whiteColor].CGColor;
    btnCrop.layer.borderWidth = 1.5;
    btnCrop.layer.cornerRadius = 3;
    btnCrop.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    cropperView.layer.borderWidth = 1.0;
    cropperView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)viewDidAppear:(BOOL)animated {
    if(isProfilePicture)
    {
        topMarginForCancel.constant = 40;
        topMarginForDone.constant = 40;
        topMarginForCropper.constant = (self.view.frame.size.height / 2) - (imageCropSize.height / 2);
    }
    else
    {
        if(IS_IPHONE_5) {
            topMarginForCancel.constant = 30;
            topMarginForDone.constant = 30;
            topMarginForCropper.constant = 80;
        }
        else if(IS_IPHONE) {
            topMarginForCancel.constant = 20;
            topMarginForDone.constant = 20;
            topMarginForCropper.constant = 50;
        }
    }
    cropperHeight.constant = imageCropSize.height;
    [cropperView setup:[imageToCrop fixOrientation]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnCrop_Clicked:(id)sender {
    UIImage *croppedImage = [cropperView finishCropping];
    [self dismissViewControllerAnimated:YES completion:nil];
    if(delegate != nil)
        [delegate imageCropperDidFinishCroppingWithImage:croppedImage];
}

- (IBAction)btnCancel_Clicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(delegate != nil)
        [delegate imageCropperDidCancel];
}
@end