//
//  CameraViewController.m
//  HalfPintPicks
//
//  Created by TechCronus on 03/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "CameraViewController.h"
#import "SellListingViewController.h"

@interface CameraViewController (CamCaptureManagerDelegate) <CamCaptureManagerDelegate>

@end

@implementation CameraViewController
{
    AVCaptureFlashMode cameraFlashMode;
    AVCaptureDevicePosition cameraMode;
    NSMutableArray *capturedImages;
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer;
    ALAssetsLibrary *assetsLibrary;
}

@synthesize scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    capturedImages = [[NSMutableArray alloc] init];
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    [self SetCameraSession];
    if ([capturedImages count] == 0)
        [self.btnNext setEnabled:NO];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    cameraFlashMode = AVCaptureFlashModeOff;
    cameraMode = AVCaptureDevicePositionBack;
    [self.btnFlash setImage:[UIImage imageNamed:@"flashlight_Off"] forState:UIControlStateNormal];
    
    //Hide FlashButton
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        [device lockForConfiguration:nil];
        device.flashMode = cameraFlashMode;
        [device unlockForConfiguration];
        [self.btnFlash setHidden:NO];
    }
    else
        [self.btnFlash setHidden:YES];
    
    if([capturedImages count] >= 5)
    {
        [self.btnCamera setEnabled:NO];
        [self.btnGallery setEnabled:NO];
    }
    else
    {
        [self.btnCamera setEnabled:YES];
        [self.btnGallery setEnabled:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Set camera session for starting capture
- (void)SetCameraSession {
    if ([self captureManager] == nil) {
        CamCaptureManager *manager = [[CamCaptureManager alloc] init];
        [self setCaptureManager:manager];
        
        [[self captureManager] setDelegate:self];
        if ([[self captureManager] setupSession:NO]) {
            // Create video preview layer and add it to the UI
            newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
            UIView *view = [self videoPreviewView];
            CALayer *viewLayer = [view layer];
            [viewLayer setMasksToBounds:YES];
            [newCaptureVideoPreviewLayer setFrame:CGRectMake(0, self.videoPreviewView.frame.origin.y, self.videoPreviewView.frame.size.width, self.videoPreviewView.frame.size.height)];
            [viewLayer insertSublayer:newCaptureVideoPreviewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
            [self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
            [[self captureManager] session ].sessionPreset = AVCaptureSessionPresetPhoto;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[[self captureManager] session] startRunning];
            });
        }
    }
}

- (IBAction)PushBack_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//TO toggle falsh mode
- (IBAction)ChangeFlashMode:(id)sender {
    switch (cameraFlashMode) {
        case AVCaptureFlashModeOff:
        {
            cameraFlashMode = AVCaptureFlashModeOn;
            [self.btnFlash setImage:[UIImage imageNamed:@"flashlight_On"] forState:UIControlStateNormal];
            break;
        }
        case AVCaptureTorchModeOn:
        {
            cameraFlashMode = AVCaptureFlashModeAuto;
            [self.btnFlash setImage:[UIImage imageNamed:@"flashlight_On"] forState:UIControlStateNormal];
            break;
        }
        case AVCaptureFlashModeAuto:
        {
            cameraFlashMode = AVCaptureFlashModeOff;
            [self.btnFlash setImage:[UIImage imageNamed:@"flashlight_Off"] forState:UIControlStateNormal];
            break;
        }
        default:
        {
            cameraFlashMode = AVCaptureFlashModeOff;
            [self.btnFlash setImage:[UIImage imageNamed:@"flashlight_Off"] forState:UIControlStateNormal];
            break;
        }
    }
    [[self captureManager] SetFlashModeForCamera:cameraFlashMode];
    
}

///Pick image for gallery
- (IBAction)GalleryImagePick:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.allowsEditing = NO;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}

//Capture image using camera
- (IBAction)CameraButton_click:(id)sender {
    [[self captureManager] captureStillImage];
    // Flash the screen white and fade it out to give UI feedback that a still image was taken
    UIView *flashView = [[UIView alloc] initWithFrame:[[self videoPreviewView] frame]];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [[[self view] window] addSubview:flashView];
    
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                     }
     ];
}

- (IBAction)Movetonext_Click:(id)sender {
    SellListingViewController *sellingVC = (SellListingViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SellListingViewController"];
    [self.navigationController pushViewController:sellingVC animated:YES];
}

//Call from cam capture manager success
- (void)captureManagerStillImageCaptured:(CamCaptureManager *)captureManager {
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSInteger numberOfAssets = [group numberOfAssets];
        if (numberOfAssets > 0) {
            NSInteger lastIndex = numberOfAssets;
            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:lastIndex - 1] options:0  usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                UIImage *thumbnail = [UIImage imageWithCGImage:[result aspectRatioThumbnail]];
                if (thumbnail && thumbnail.size.width > 0) {
                    thumbnail = [[thumbnail fixOrientation] cropImageForCorrectAspectRatio];
                    thumbnail = [thumbnail scaleImageToNewSize:newCaptureVideoPreviewLayer.frame.size];
                    [self ProductImageCaptured:thumbnail];
                    NSLog(@"%lu",(unsigned long)[capturedImages count]);
                    *stop = YES;
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
}

//Method to process captured image
- (void)ProductImageCaptured:(UIImage*)capturedImage {
    if([capturedImages count] < 5)
    {
        [capturedImages addObject:capturedImage];
        [self DisplayProductImages];
    }
    
}

//Display capture image
- (void)DisplayProductImages {
    for(UIView *image in self.scrollView.subviews)
    {
        [image removeFromSuperview];
    }
    [scrollView setContentSize:CGSizeMake([capturedImages count] * 75 + 10,scrollView.frame.size.height)];
    //[scrollView setBackgroundColor:[UIColor redColor]];
    
    for(int i = 0; i < [capturedImages count]; i++)
    {
        UIImageView *imgPreview = [[UIImageView alloc]initWithFrame:CGRectMake((i == 0 ? 10 :i * 75 + 10), 5, 65, 65)];
        imgPreview.image = [capturedImages objectAtIndex:i];
        imgPreview.layer.borderWidth = 0.5f;
        imgPreview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UIImage *removeImage = [UIImage imageNamed:@"remove_image.png"];
        UIImageView *removeImageView = [[UIImageView alloc] initWithImage:removeImage];
        removeImageView.tag = i;
        [removeImageView setFrame:CGRectMake(imgPreview.frame.origin.x + imgPreview.frame.size.width - 10, imgPreview.frame.origin.y - 5, 15, 15)];
        //[removeImageView setCenter:CGPointMake(imgPreview.bounds.size.width - 5, imgPreview.bounds.size.height/2 - 28 )];
        removeImageView.layer.cornerRadius = 7.0f;
        [removeImageView setBackgroundColor:[UIColor blackColor]];
        UITapGestureRecognizer *removeImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeImage_Tapped:)];
        removeImageTap.numberOfTapsRequired = 1;
        removeImageView.userInteractionEnabled = YES;
        [removeImageView addGestureRecognizer:removeImageTap];
        
        [scrollView addSubview:imgPreview];
        [scrollView addSubview:removeImageView];
    }
    
    if ([capturedImages count] == 0)
        [self.btnNext setEnabled:NO];
    else
        [self.btnNext setEnabled:YES];
    
    if([capturedImages count] >= 5)
    {
        [self.btnCamera setEnabled:NO];
        [self.btnGallery setEnabled:NO];
    }
    else
    {
        [self.btnCamera setEnabled:YES];
        [self.btnGallery setEnabled:YES];
        
    }
    
}

- (void)removeImage_Tapped:(UIGestureRecognizer *)gestureRecognizer {
    [capturedImages removeObjectAtIndex:[gestureRecognizer view].tag];
    [self DisplayProductImages];
    if ([capturedImages count] == 0)
        [self.btnNext setEnabled:NO];
}

#pragma Image gallery delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self ProductImageCaptured:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
