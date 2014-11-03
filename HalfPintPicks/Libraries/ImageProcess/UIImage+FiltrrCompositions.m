

#import "UIImage+FiltrrCompositions.h"
#import "UIImage+Filtrr.h"

@implementation UIImage (FiltrrCompositions)

#pragma mark - DebugHelper

-(id) trackTime:(NSString *)method {
    NSDate *startdate = [NSDate date]; 
    
    SEL _selector = NSSelectorFromString(method);
    id retVal = [self performSelector:_selector];
    
    NSDate *enddate = [NSDate date];
    
    NSTimeInterval diff = [enddate timeIntervalSinceDate:startdate];
    NSLog(@"returning new image from %@ with time: %f", method, diff);
    
    return retVal;
}

#pragma mark - Compositions

-(id) Retro {
    
    UIImage *topImage = [self duplicate];
    topImage = [[topImage saturationByFactor:0] blur];
    
    UIImage * newImage = [self multiply:topImage];
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 170;
    maxrgb.green = 140;
    maxrgb.blue = 160;
    
    newImage = [[[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.8] brightnessByFactor:10];
    
    return newImage;
    
}

-(id) Street {
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 10;
    minrgb.green = 10;
    minrgb.blue = 10;
    
    maxrgb.red = 190;
    maxrgb.green = 205;
    maxrgb.blue = 230;

    return [[[self posterizeByLevel:70] tintWithMinRGB:minrgb MaxRGB:maxrgb] brightnessByFactor:0.6];
}

-(id) Modern {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 170;
    maxrgb.green = 170;
    maxrgb.blue = 230;
    
    return [[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.8];
}

-(id) Timeless {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 60;
    minrgb.blue = 30;
    
    maxrgb.red = 210;
    maxrgb.green = 210;
    maxrgb.blue = 210;
    
    return [[self grayScale] tintWithMinRGB:minrgb MaxRGB:maxrgb];
}

-(id) Chic {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 30;
    minrgb.green = 40;
    minrgb.blue = 30;
    
    maxrgb.red = 120;
    maxrgb.green = 170;
    maxrgb.blue = 210;
    
    return [[[[[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.75] biasByFactor:1] saturationByFactor:0.6] brightnessByFactor:20];
}

-(id) Glam {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 30;
    minrgb.green = 40;
    minrgb.blue = 30;
    
    maxrgb.red = 190;
    maxrgb.green = 170;
    maxrgb.blue = 210;
    
    return [[[self saturationByFactor:0.4] contrastByFactor:0.75] tintWithMinRGB:minrgb MaxRGB:maxrgb];
}

- (id) Polaroidish { 
    UIImage *newImage = [[[self adjustRedChannel:0.1 GreenChannel:0.5 BlueChannel:0.9] saturationByFactor:0.6] contrastByFactor:1.0];
    
    return newImage;
}

- (id) Vintage {
    UIImage *img = [self duplicate];
    //apply sepia filter - taken from the Beginning Core Image from iOS5 by Tutorials
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(img)];
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:1.0], nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *img1 = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return [[img1 vignetteWithRadius:0 andIntensity:8] brightnessByFactor:0.3];
}

-(UIImage *)blendMode:(NSString *)blendMode withImageNamed:(NSString *) imageName{
    
    /*
     Blend Modes
     
     CISoftLightBlendMode
     CIMultiplyBlendMode
     CISaturationBlendMode
     CIScreenBlendMode
     CIMultiplyCompositing
     CIHardLightBlendMode
     */
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[self duplicate]];
    
    //try with different textures
    CIImage *bgCIImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter= [CIFilter filterWithName:blendMode];
    
    
    // inputBackgroundImage most be the same size as the inputImage
    
    [filter setValue:inputImage forKey:@"inputBackgroundImage"];
    [filter setValue:bgCIImage forKey:@"inputImage"];
    
    return [self imageFromContext:context withFilter:filter];
}

- (id) Vignette { 
    return [self vignetteWithRadius:0 andIntensity:10];
}

- (UIImage *)vignetteWithRadius:(float)inputRadius andIntensity:(float)inputIntensity{
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter= [CIFilter filterWithName:@"CIVignette"];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[self duplicate]];
    
    [filter setValue:inputImage forKey:@"inputImage"];
    
    [filter setValue:[NSNumber numberWithFloat:inputIntensity] forKey:@"inputIntensity"];
    [filter setValue:[NSNumber numberWithFloat:inputRadius] forKey:@"inputRadius"];
    
    return [self imageFromContext:context withFilter:filter];
}

- (UIImage*)imageFromContext:(CIContext*)context withFilter:(CIFilter*)filter {
    
    CGImageRef imageRef = [context createCGImage:[filter outputImage] fromRect:filter.outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef]; //scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
    
}

- (id) Sepia {
        UIImage *img = [self duplicate];
        //apply sepia filter - taken from the Beginning Core Image from iOS5 by Tutorials
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(img)];
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues: kCIInputImageKey, beginImage,
                            @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *img1 = [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);
        
        return img1;
}

-(id)ExposureAdjust {
    
    EAGLContext *myEAGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{ kCIContextWorkingColorSpace : [NSNull null] };
    CIContext *context = [CIContext contextWithEAGLContext:myEAGLContext options:options];

    
    //CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *img = [self duplicate];
    //apply sepia filter - taken from the Beginning Core Image from iOS5 by Tutorials
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(img)];
    //CIFilter *filter= [CIFilter filterWithName:@"CIExposureAdjust"];
    
    
    CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues: kCIInputImageKey, inputImage,
                        @"inputEV", [NSNumber numberWithFloat:0.5], nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *img1 = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);

    
    return img1;
}

- (id) Classic {
    
    UIImage *image = [self duplicate];
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, 0);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

- (id) Lomo
{
    UIImage *image = [[[[self duplicate] adjustRedChannel:0.3 GreenChannel:0.3 BlueChannel:0.1] saturationByFactor:0.8] contrastByFactor:1.5];
    return [image vignetteWithRadius:0.5 andIntensity:10];
}

@end
