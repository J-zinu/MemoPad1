//
//  DetailViewController.m
//  MemoPad1
//
//  Created by JinWoo Jeong on 4/24/24.
//

#import "MPDetailViewController.h"
#import "MemoData.h"
#import "AppDelegate.h"

//@interface MPDetailViewController ()

//@end

@implementation MPDetailViewController

@synthesize lblTitle = _lblTitle;
@synthesize lblDate = _lblDate;
@synthesize tvContent = _tvContent;
@synthesize sliderFontSize = _sliderFontSize;
@synthesize btnEdit = _btnEdit;
@synthesize btnDelete = _btnDelete;
@synthesize mData;



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate readMemoFromDatabase];
    self.mData = [[appDelegate DBData] objectAtIndex:[appDelegate currentMemoRowIndex]];
    
    //얻어낸 MemoData 오브젝트에서 제목, 날짜, 내용을 해당 UI 요소의 .text 속성에 할당한다.
    _lblDate.text = [self.mData mTitle];
    _lblTitle.text = [self.mData mDate];
    _tvContent.text = [self.mData mContent];
    
    _tvContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];

    
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}


- (IBAction)changeFontSize:(id)sender { }

- (IBAction)editMemo:(id)sender { }

- (IBAction)deleteMemo:(id)sender { }



@end
