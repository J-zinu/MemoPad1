//
//  MPEditViewController.m
//  MemoPad1
//
//  Created by JinWoo Jeong on 5/7/24.
//

#import "MPEditViewController.h"
#import "AppDelegate.h"
@interface MPEditViewController ()

@end

@implementation MPEditViewController
@synthesize btnCancel;
@synthesize btnSave;
@synthesize tfTitle;
@synthesize tvContent;
@synthesize mData;




- (void)viewDidLoad {
    [super viewDidLoad];
   
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.mData = [[appDelegate DBData] objectAtIndex:[appDelegate currentMemoRowIndex]];
    
    self.tfTitle.text = [self.mData mTitle];
    self.tvContent.text = [self.mData mContent];
    self.tvContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tfTitle becomeFirstResponder];
}



-(IBAction)cancelMemo:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)saveMemo:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    [appDelegate upDateMemoToDatabaseWithTitle:[self.tfTitle text] Content:[self.tvContent text]];
    [self dismissModalViewControllerAnimated:YES];
}


@end
