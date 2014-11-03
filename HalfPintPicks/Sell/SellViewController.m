//
//  SellViewController.m
//  HalfPintPicks
//

//  Copyright (c) 2014 TechCronus . All rights reserved.
//

#import "SellViewController.h"
#import "CameraViewController.h"

@interface SellViewController ()

@end

@implementation SellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)WHITEGLOW_Click:(id)sender {
}
- (IBAction)LISTYOURSELF_Click:(id)sender {
    CameraViewController *cameraVC  = (CameraViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    [self.tabBarController hidesBottomBarWhenPushed];
    [self.navigationController pushViewController:cameraVC animated:YES];
}
@end
