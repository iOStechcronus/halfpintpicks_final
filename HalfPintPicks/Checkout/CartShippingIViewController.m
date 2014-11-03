//
//  CartShippingIViewController.m
//  HalfPintPicks
//
//  Created by MAAUMA on 10/22/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#import "CartShippingIViewController.h"

@interface CartShippingIViewController ()

@end

@implementation CartShippingIViewController
{
    NSString *validationString;
    NSString *requiredFieldValidationMessage;
}
@synthesize scrollView,lblAddressOne,lblAddressTwo,lblCity,lblInstruction,lblName,lblState,lblZip,txtAddressTwo,txtCity,txtEnterName,txtEnterState,txtEnterZip,txtStreetAddress,mainContainerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Intilization];
    // Do any additional setup after loading the view.
}

//Intial method to set all Intial

- (void)Intilization {
    [scrollView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGeature = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RevertEditing)];
    tapGeature.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tapGeature];
    requiredFieldValidationMessage= [HelperMethod GetLocalizeTextForKey:@"VALIDATION_FIELDS_REQUIRED"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [scrollView setFrame:CGRectMake(0, 98, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight] - 64 -50)];
    [scrollView setContentSize:CGSizeMake(320, 365)];
}


//Method to set scrollview position to intial conditions and end editing for textfields
- (void)RevertEditing {
    [self.view endEditing:YES];
    [scrollView setContentSize:CGSizeMake(320, 365)];
    [scrollView scrollRectToVisible:CGRectMake(0, 98, [HelperMethod GetDeviceWidth], [HelperMethod GetDeviceHeight]) animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//Method to check all requiredField validations
- (NSString *)requireFieldsValidations {
    validationString = @"";
    if ([self.txtEnterName.text length] == 0)
        validationString = lblName.text;
    
    if ([self.txtStreetAddress.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblAddressOne.text];
    }
    
    if ([self.txtCity.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblCity.text];
    }
    if ([self.txtEnterState.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblState.text];
    }
    if ([self.txtEnterZip.text length] == 0) {
        if ([validationString length] > 0)
            validationString = [validationString stringByAppendingString:@"\n"];
        validationString = [validationString stringByAppendingString:lblZip.text];
    }
    return validationString;
}


- (IBAction)btnCheckout_Click:(id)sender {
    validationString = [self requireFieldsValidations];
    if ([validationString length] > 0)
        validationString = [requiredFieldValidationMessage stringByAppendingString:validationString];
    
    if ([validationString length] > 0)
    {
        UIAlertView *codeAlert = [[UIAlertView alloc]initWithTitle:[HelperMethod GetLocalizeTextForKey:@"APP_NAME"] message:validationString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [codeAlert show];
    }
    else
    {
       // [self SaveShippingInfo];
    }
}

#pragma TextField Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(IS_IPHONE && !IS_IPHONE_5)
    {
        if([txtAddressTwo isEqual:textField] || [txtCity isEqual:textField] || [txtEnterState isEqual:textField] || [txtEnterZip isEqual:textField])
        {
            [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 600)];
            [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y - 5, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
        
        
    }
    else if (IS_IPHONE_5)
    {
        if([txtCity isEqual:textField] || [txtEnterZip isEqual:textField] || [txtEnterState isEqual:textField])
        {
            [scrollView setContentSize:CGSizeMake([HelperMethod GetDeviceWidth], 550)];
            [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y -  5, [HelperMethod GetDeviceWidth], scrollView.frame.size.height) animated:YES];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txtEnterName isEqual:textField])
    {
        [txtEnterName resignFirstResponder];
        [txtStreetAddress becomeFirstResponder];
    }
    else if ([txtStreetAddress isEqual:textField])
    {
        [txtStreetAddress resignFirstResponder];
        [txtAddressTwo becomeFirstResponder];
    }
    else if ([txtAddressTwo isEqual:textField])
    {
        [txtAddressTwo resignFirstResponder];
        [txtCity becomeFirstResponder];
    }
    else if ([txtCity isEqual:textField])
    {
        [txtCity resignFirstResponder];
        [txtEnterState becomeFirstResponder];
    }
    else if ([txtEnterState isEqual:textField])
    {
        [txtEnterState resignFirstResponder];
        [txtEnterZip becomeFirstResponder];
    }
    else if ([txtEnterZip isEqual:textField])
    {
        [txtEnterZip resignFirstResponder];
        [self RevertEditing];
    }
    
    return YES;
}

- (IBAction)Back_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
