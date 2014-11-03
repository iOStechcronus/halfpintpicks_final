//
//  AKLookups.h


#import <UIKit/UIKit.h>
@class AKDropdownViewController;
@class AKLookups;

@protocol AKLookupsCapableItem <NSObject>
@required
@property (nonatomic, strong) NSString* lookupTitle;
@end

@interface AKLookups : UIButton
@property (nonatomic, strong) id<AKLookupsCapableItem> selectedItem;

-(instancetype)initWithLookupViewController:(AKDropdownViewController*)viewController;
-(void)closeAnimation;
-(void)selectItem:(id<AKLookupsCapableItem>)item;
-(void)openLookup;
-(void)closeLookup;
@end
