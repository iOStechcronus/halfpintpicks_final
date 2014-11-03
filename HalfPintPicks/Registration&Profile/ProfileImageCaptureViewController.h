//
//  ProfileImageCaptureViewController.h
//  HalfPintPicks
//
//  Created by MAAUMA on 10/29/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CamCaptureManager.h"
#include <AssetsLibrary/AssetsLibrary.h>

@protocol ProfilePictureDelegate <NSObject>
@optional
- (void)profilePictureCapturedSuccessfully:(UIImage*)profileImage;
@end

@class CamCaptureManager,CamPreviewView, AVCaptureVideoPreviewLayer;

@interface ProfileImageCaptureViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnFlash;
@property (strong, nonatomic) IBOutlet UIButton *btnGallery;
@property (nonatomic, strong) id<ProfilePictureDelegate> profilePictureDelegate;
- (IBAction)PushBack_click:(id)sender;
- (IBAction)ChangeFlashMode:(id)sender;
- (IBAction)GalleryImagePick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
- (IBAction)CameraButton_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;

@property (nonatomic,assign) CamCaptureManager *captureManager;
@property (nonatomic,assign) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@end
