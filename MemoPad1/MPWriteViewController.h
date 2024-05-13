//
//  MPWriteViewController.h
//  MemoPad1
//
//  Created by JinWoo Jeong on 5/7/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SceneDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MPWriteViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;

@property (weak, nonatomic) IBOutlet UITextView *tvContent;

- (IBAction)cancelMemo:(id)sender;

- (IBAction)saveMemo:(id)sender;

@end

NS_ASSUME_NONNULL_END
