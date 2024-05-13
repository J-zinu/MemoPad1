//
//  MPWriteViewController.m
//  MemoPad1
//
//  Created by JinWoo Jeong on 5/7/24.
//

#import "MPWriteViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
@interface MPWriteViewController ()

@end

@implementation MPWriteViewController
@synthesize btnCancel;
@synthesize btnSave;
@synthesize tfTitle;
@synthesize tvContent;


- (void)viewDidUnload {
    
    [self setTfTitle:nil];
    [self setTvContent:nil];
    [self setBtnCancel:nil];
    [self setBtnSave:nil];
    [super viewDidLoad];
    
}


//- (IBAction)cancelMemo:(id)sender {
//    [self dismissModalViewControllerAnimated:YES];
//}
- (IBAction)cancelMemo:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
   }


- (IBAction)saveMemo:(id)sender {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate writeMemoToDataBaseWithTitle:[self.tfTitle text] Content:[self.tvContent text]];
        [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [self.tfTitle becomeFirstResponder];
}

@end
