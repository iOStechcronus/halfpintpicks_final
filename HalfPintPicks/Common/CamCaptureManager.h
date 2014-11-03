#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class CamRecorder;
@protocol CamCaptureManagerDelegate;

@interface CamCaptureManager : NSObject {
}

@property (nonatomic,retain) AVCaptureSession *session;
@property (nonatomic,assign) AVCaptureVideoOrientation orientation;
@property (nonatomic,retain) AVCaptureDeviceInput *videoInput;
@property (nonatomic,retain) AVCaptureDeviceInput *audioInput;
@property (nonatomic,retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic,assign) id deviceConnectedObserver;
@property (nonatomic,assign) id deviceDisconnectedObserver;
@property (nonatomic,assign) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic,assign) id <CamCaptureManagerDelegate> delegate;

- (BOOL) setupSession:(bool)isProfilePicture;
- (void) captureStillImage;
- (BOOL) toggleCamera;
- (NSUInteger) cameraCount;
- (NSUInteger) micCount;
- (void) autoFocusAtPoint:(CGPoint)point;
- (void) continuousFocusAtPoint:(CGPoint)point;
- (void)SetFlashModeForCamera:(AVCaptureFlashMode)cameraFlashMode;

@end

// These delegate methods can be called on any arbitrary thread. If the delegate does something with the UI when called, make sure to send it to the main thread.
@protocol CamCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(CamCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerRecordingBegan:(CamCaptureManager *)captureManager;
- (void) captureManagerRecordingFinished:(CamCaptureManager *)captureManager;
- (void) captureManagerStillImageCaptured:(CamCaptureManager *)captureManager withImage:(UIImage*)capturedImage;
- (void) captureManagerDeviceConfigurationChanged:(CamCaptureManager *)captureManager;
@end
