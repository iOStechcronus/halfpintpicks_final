//
//  CameraViewController.h
//  HalfPintPicks
//
//  Created by TechCronus on 03/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CamCaptureManager.h"
#include <AssetsLibrary/AssetsLibrary.h>

@class CamCaptureManager,CamPreviewView, AVCaptureVideoPreviewLayer;

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnFlash;
@property (strong, nonatomic) IBOutlet UIButton *btnGallery;
- (IBAction)PushBack_click:(id)sender;
- (IBAction)ChangeFlashMode:(id)sender;
- (IBAction)GalleryImagePick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
- (IBAction)CameraButton_click:(id)sender;
- (IBAction)Movetonext_Click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,assign) CamCaptureManager *captureManager;
@property (nonatomic,assign) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@end
