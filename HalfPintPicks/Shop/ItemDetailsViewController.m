//
//  ItemDetailsViewController.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/8/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "ItemPictures.h"
#import "EGOImageView.h"

@interface ItemDetailsViewController ()

@end

@implementation ItemDetailsViewController {
    int selectedIndex,imageCount;
    NSMutableArray *itemToShareOnFacebook;
    UIActivityViewController *shareOnFacebook;
    EGOImageView *egoImageview;
}

@synthesize lblOriginalPrice, lblSellingPrice, btnAddtocart, btnDetails, btnPhotos, btnShare, scrollImage, btnShareInstagram;
@synthesize lblBrand, lblBrandName, lblCondition, lblConditionValue, lblDescription, lblGender, lblGenderDetail, lblGenderName, lblInstruction, lblInstructionHeader, lblItemDescription, lblItemname, lblLocation, lblLocationName, lblShipping, lblShippingPrice, lblSize,lblSizeDetail,lblSizeName, lblTime, lblUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Intilization];
    self.scrollView.delegate = self;
    self.HorizontalScrollview.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method to Intilization of intial variables and methods
- (void)Intilization {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$ %@", @"1500"]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@1
                            range:NSMakeRange(0, [attributeString length]-1)];
    lblOriginalPrice.attributedText = attributeString;
    
    self.vwPhotos.hidden = NO;
    self.vwShare.hidden = YES;
    self.vwDetails.hidden = YES;
    selectedIndex = FirstIndex;
    self.scrollView.contentSize = CGSizeMake([HelperMethod GetDeviceWidth], 400);
    [self setValueForControls];
}

//TO set value for all controls
- (void)setValueForControls {
    ItemPictures *itemPicture = [[ItemPictures alloc]init];
    itemPicture.ImageUrl = @"";
    itemPicture.Sequence = 1;
    NSMutableArray *arrImages = [[NSMutableArray alloc]init];
    [arrImages addObject:itemPicture];
    
    itemPicture = [[ItemPictures alloc]init];
    itemPicture.ImageUrl = @"";
    itemPicture.Sequence = 2;
    [arrImages addObject:itemPicture];
    
    itemPicture = [[ItemPictures alloc]init];
    itemPicture.ImageUrl = @"";
    itemPicture.Sequence = 3;
    [arrImages addObject:itemPicture];
    
    [self clearScrollView];
    [self AddImagesToScrollView:arrImages];
    
    self.imgUserImage.image = [UIImage imageNamed:@"Profile_1"];
    self.imgUserImage.layer.borderWidth = 1.0f;
    self.imgUserImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imgUserImage.layer.cornerRadius = 12.0f;
    self.imgUserImage.layer.masksToBounds =YES;
    
    NSString *itemPrice = [NSString stringWithFormat:@"%@", @"6 mo - 12 mo"];
    CGRect itemPricerect = [itemPrice boundingRectWithSize:CGSizeMake(1000, 16)
                                                   options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]} context:nil];
    CGSize itemPriceRectSize = itemPricerect.size;
    self.sizeConstant.constant = itemPriceRectSize.width;
    self.lblSize.text = itemPrice;
}

- (void)setValuesForItemDetails {
    lblBrand.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Brand"];
    lblGenderDetail.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_GenderDetail"];
    lblSizeDetail.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_SizeDetail"];
    lblDescription.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Description"];
    lblLocation.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Location"];
    lblCondition.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Condition"];
    lblShipping.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Shipping"];
    lblInstructionHeader.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_InstructionHeader"];
    lblInstruction.text = [HelperMethod GetLocalizeTextForKey:@"ItemDetails_lbl_Instruction"];
}

#pragma Scrollview Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = [HelperMethod GetDeviceWidth];
    if(scrollView == self.HorizontalScrollview)
    {
        imageCount = floor((self.HorizontalScrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [self changePage:imageCount];
    }
}

#pragma Custom Methods for animations
- (void)fadeinView:(UIView *)viewtofadein {
    [viewtofadein setAlpha:0.0f];
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [viewtofadein setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [viewtofadein setHidden:NO];
    }];
}

- (void)fadeOutView:(UIView *)viewtofadeout {
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [viewtofadeout setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [viewtofadeout setHidden:YES];
    }];
}

//Share on facebook and twitter
- (void)shareItemOnSocialNetworking {
    itemToShareOnFacebook = [[NSMutableArray alloc] initWithObjects:@"I am Vandan.Javiya Dagly & I am an iOS developer.", [UIImage imageNamed:@"back_icon"], @"https://www.google.co.in", nil];
    shareOnFacebook = [[UIActivityViewController alloc] initWithActivityItems:itemToShareOnFacebook applicationActivities:nil];
    shareOnFacebook.excludedActivityTypes = @[UIActivityTypeMessage,
                                              UIActivityTypePrint,
                                              UIActivityTypeCopyToPasteboard,
                                              UIActivityTypeAssignToContact,
                                              UIActivityTypeSaveToCameraRoll,
                                              UIActivityTypeAirDrop,
                                              UIActivityTypePostToTencentWeibo,
                                              UIActivityTypePostToWeibo,
                                              UIActivityTypePostToVimeo,
                                              UIActivityTypePostToFlickr,
                                              UIActivityTypeAddToReadingList];
    [self presentViewController:shareOnFacebook animated:YES completion:nil];
}

//This is custom method to add images to scroll view in item details
- (void)AddImagesToScrollView:(NSMutableArray *)imagesDetails {
    [self.HorizontalScrollview setContentSize:CGSizeMake([HelperMethod GetDeviceWidth] * [imagesDetails count] , self.HorizontalScrollview.frame.size.height)];
    for (int i = 0; i < imagesDetails.count; i++) {
        ItemPictures *imageInfo = (ItemPictures *) [imagesDetails objectAtIndex:i];
        egoImageview = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Placeholder_itemDetail.png"]];
        if (![imageInfo.ImageUrl isEqualToString:@""]) {
            NSString *imageURL1 = imageInfo.ImageUrl;
            imageURL1 = [imageURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [egoImageview setImageURL:[NSURL URLWithString:imageURL1]];
        }
        else
        {
            if(imageInfo.Sequence == 1)
                [egoImageview setImage:[UIImage imageNamed:@"baby_1"]];
            else if(imageInfo.Sequence == 2)
                [egoImageview setImage:[UIImage imageNamed:@"baby_2"]];
            else if (imageInfo.Sequence == 3)
                [egoImageview setImage:[UIImage imageNamed:@"baby_3"]];
        }
        egoImageview.tag = i;
        egoImageview.frame = CGRectMake([HelperMethod GetDeviceWidth] * i, 0, [HelperMethod GetDeviceWidth], self.HorizontalScrollview.frame.size.height);
        
        UITapGestureRecognizer *doubletapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomCurrentImage:)];
        doubletapGesture.numberOfTapsRequired = 1;
        doubletapGesture.numberOfTouchesRequired = 1;
        egoImageview.userInteractionEnabled = YES;
        //[egoImageview addGestureRecognizer:doubletapGesture];
        
        [self.HorizontalScrollview addSubview:egoImageview];
    }
    [self.HorizontalScrollview scrollRectToVisible:CGRectMake(0, 0, [HelperMethod GetDeviceWidth], self.HorizontalScrollview.frame.size.height) animated:NO];
}

- (void)clearScrollView {
    for (UIView *v in self.HorizontalScrollview.subviews) {
        [v removeFromSuperview];
    }
}

//CHnage page event while user scroll page
- (void)changePage:(int)productNumber {
    CGPoint offset = CGPointMake(productNumber * self.HorizontalScrollview.frame.size.width, 0);
    [self.HorizontalScrollview setContentOffset:offset animated:YES];
    self.pgImgesIndicator.currentPage = productNumber;
}

#pragma Button Click Events

- (IBAction)AddCart_Click:(id)sender {
}

- (IBAction)SegmentChange_Click:(id)sender {
    UIButton *btnSelected = (UIButton *)sender;
    if(btnSelected.tag == 15)
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(0, 0, scrollImage.frame.size.width, scrollImage.frame.size.height);
            btnPhotos.backgroundColor = [UIColor clearColor];
            btnDetails.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            btnShare.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        }completion:^(BOOL complete){
            //
        }];
        
        if(selectedIndex == SecondIndex)
        {
            [self fadeOutView:self.vwDetails];
            [self fadeinView:self.vwPhotos];
        }
        else if (selectedIndex == ThirdIdex)
        {
            [self fadeOutView:self.vwShare];
            [self fadeinView:self.vwPhotos];
        }
        selectedIndex = FirstIndex;
    
    
    }
    else if (btnSelected.tag == 16)
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(107, 0, scrollImage.frame.size.width, self.scrollImage.frame.size.height);
            self.btnDetails.backgroundColor = [UIColor clearColor];
            self.btnPhotos.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            self.btnShare.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        } completion:^(BOOL complete){
            [self setValuesForItemDetails];
        }];
        
        if(selectedIndex == FirstIndex)
        {
            [self fadeinView:self.vwDetails];
            [self fadeOutView:self.vwPhotos];
        }
        else if (selectedIndex == ThirdIdex)
        {
            [self fadeinView:self.vwDetails];
            [self fadeOutView:self.vwShare];
        }
        selectedIndex = SecondIndex;
        

    }
    else
    {
        [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionCurveLinear & UIViewAnimationOptionBeginFromCurrentState) animations:^{
            scrollImage.frame = CGRectMake(214, 0, self.scrollImage.frame.size.width, self.scrollImage.frame.size.height);
            self.btnShare.backgroundColor = [UIColor clearColor];
            self.btnPhotos.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            self.btnDetails.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        } completion:^(BOOL complete) {
            
        }];

        if(selectedIndex == FirstIndex)
        {
            [self fadeinView:self.vwShare];
            [self fadeOutView:self.vwPhotos];
        }
        else if (selectedIndex == SecondIndex)
        {
            [self fadeinView:self.vwShare];
            [self fadeOutView:self.vwDetails];
        }
        selectedIndex = ThirdIdex;
    }
}

- (IBAction)Share_Click:(id)sender {
    [self shareItemOnSocialNetworking];
}

- (IBAction)Back_CLick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnShareInstagram_click:(id)sender {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        CGFloat cropVal = (egoImageview.image.size.height > egoImageview.image.size.width ? egoImageview.image.size.width : egoImageview.image.size.height);
        
        cropVal *= [egoImageview.image scale];
        
        CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
        CGImageRef imageRef = CGImageCreateWithImageInRect([egoImageview.image CGImage], cropRect);
        
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
        CGImageRelease(imageRef);
        
        NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
        if (![imageData writeToFile:writePath atomically:YES]) {
            // failure
            NSLog(@"image save failed to path %@", writePath);
            return;
        }
        else {
            // success.
        }
        
        // send it to instagram.
        NSURL *fileURL = [NSURL fileURLWithPath:writePath];
        self.dic = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.dic.delegate = self;
        [self.dic setUTI:@"com.instagram.exclusivegram"];
        [self.dic setAnnotation:@{@"InstagramCaption" : @"Test Images"}];
        [self.dic presentOpenInMenuFromRect:CGRectMake(0, 0, 320, 480) inView:self.view animated:YES];
    }
    else {
        NSLog (@"Instagram not found");
    }
}

@end
