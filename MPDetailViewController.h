//
//  DetailViewController.h
//  MemoPad1
//
//  Created by JinWoo Jeong on 4/24/24.
//

#import <UIKit/UIKit.h>
#import "MemoData.h"
#import "MPEditViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MPDetailViewController : UIViewController <UIAlertViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@property (weak, nonatomic) IBOutlet UISlider *sliderFontSize;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDelete;
@property (weak, nonatomic) MemoData *mData;

//- (IBAction)changeFontSize:(id)sender;
- (IBAction)changeFontSize:(id)sender;
- (IBAction)editMemo:(id)sender;
- (IBAction)deleteMemo:(id)sender;

@end

NS_ASSUME_NONNULL_END
