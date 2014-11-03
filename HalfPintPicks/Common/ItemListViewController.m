//
//  ItemListViewController.m

#import "ItemListViewController.h"
#import "EGOImageView.h"


@interface ItemListViewController ()

@end

@implementation ItemListViewController

@synthesize itemImage,btnLike, itemInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 3.0f;
	[self setValuesForControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    //[itemImage setImage:[UIImage imageNamed:@"Placeholder_itemlisting"]];
}

- (void)setValuesForControl {
    itemImage.userInteractionEnabled = YES;
    
    if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"MyProfileViewController"])
    {
        if (![itemInfo.ItemFrontImage isEqualToString:@""]) {
            NSString *imageURL1 = itemInfo.ItemFrontImage;
            imageURL1 = [imageURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [itemImage setImageURL:[NSURL URLWithString:imageURL1]];
        }
        else
            [itemImage setImage:[UIImage imageNamed:@"baby_1.png"]];
        self.lblitemName.text = itemInfo.ItemName;
        self.lblComment.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemCommentCount];
        self.lblLike.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemLikeCount];
        self.lblPrice.text = [NSString stringWithFormat:@"$%d",itemInfo.ItemPrice];

    }
    else if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"ShopViewController"])
    {
        
        if (![itemInfo.ItemFrontImage isEqualToString:@""]) {
            NSString *imageURL1 = itemInfo.ItemFrontImage;
            imageURL1 = [imageURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [itemImage setImageURL:[NSURL URLWithString:imageURL1]];
        }
        else
            [itemImage setImage:[UIImage imageNamed:@"baby_2.png"]];
        self.lblitemName.text = itemInfo.ItemName;
        self.lblComment.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemCommentCount];
        self.lblLike.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemLikeCount];
        self.lblPrice.text = [NSString stringWithFormat:@"$ %d",itemInfo.ItemPrice];
    }
    else if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"FavouritesViewController"])
    {
        
        if (![itemInfo.ItemFrontImage isEqualToString:@""]) {
            NSString *imageURL1 = itemInfo.ItemFrontImage;
            imageURL1 = [imageURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [itemImage setImageURL:[NSURL URLWithString:imageURL1]];
        }
        else
            [itemImage setImage:[UIImage imageNamed:@"baby_3.png"]];
        self.lblitemName.text = itemInfo.ItemName;
        self.lblComment.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemCommentCount];
        self.lblLike.text = [NSString stringWithFormat:@"%d", itemInfo.TotalUserItemLikeCount];
        self.lblPrice.text = [NSString stringWithFormat:@"$ %d",itemInfo.ItemPrice];
    }
}
@end
