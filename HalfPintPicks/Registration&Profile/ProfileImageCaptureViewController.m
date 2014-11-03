//
//  ProfileImageCaptureViewController.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/29/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "ProfileImageCaptureViewController.h"

@interface ProfileImageCaptureViewController (CamCaptureManagerDelegate) <CamCaptureManagerDelegate>

@end

@implementation ProfileImageCaptureViewController
{
    AVCaptureFlashMode cameraFlashMode;
    AVCaptureDevicePosition cameraMode;
    NSMutableArray *capturedImages;
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer;
    ALAssetsLibrary *assetsLibrary;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    capturedImages = [[NSMutableArray alloc] init];
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self SetCameraSession];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if([capturedImages count] >= 1)
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

- (void)SetCameraSession {
    if ([self captureManager] == nil) {
        CamCaptureManager *manager = [[CamCaptureManager alloc] init];
        [self setCaptureManager:manager];
        
        [[self captureManager] setDelegate:self];
        if ([[self captureManager] setupSession:YES]) {
            // Create video preview layer and add it to the UI
            newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
            UIView *view = [self videoPreviewView];
            CALayer *viewLayer = [view layer];
            [viewLayer setMasksToBounds:YES];
            [newCaptureVideoPreviewLayer setFrame:CGRectMake(0, 0, self.videoPreviewView.frame.size.width, self.videoPreviewView.frame.size.height)];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)GalleryImagePick:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.allowsEditing = NO;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}


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

- (void)captureManagerStillImageCaptured:(CamCaptureManager *)captureManager {
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSInteger numberOfAssets = [group numberOfAssets];
        if (numberOfAssets > 0) {
            NSInteger lastIndex = numberOfAssets;
            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:lastIndex - 1] options:0  usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                UIImage *thumbnail = [UIImage imageWithCGImage:[result aspectRatioThumbnail]];
                if (thumbnail && thumbnail.size.width > 0) {
                    thumbnail = [[thumbnail fixOrientation] cropImageForCorrectAspectRatio];
                    [self ProfileImageCaptured:thumbnail];
                    NSLog(@"%lu",(unsigned long)[capturedImages count]);
                    *stop = YES;
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
}
- (void)ProfileImageCaptured:(UIImage*)capturedImage {
    capturedImages = [[NSMutableArray alloc]init];
    capturedImage = [[capturedImage fixOrientation] scaleImageToNewSize:CGSizeMake(150, 150)];
    if([capturedImages count] < 1)
        [capturedImages addObject:capturedImage];
    if(self.profilePictureDelegate != nil)
        [self.profilePictureDelegate profilePictureCapturedSuccessfully:[capturedImages objectAtIndex:0] ];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma Image gallery delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self ProfileImageCaptured:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
