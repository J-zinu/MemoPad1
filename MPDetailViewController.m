//
//  DetailViewController.m
//  MemoPad1
//
//  Created by JinWoo Jeong on 4/24/24.
//

#import "MPDetailViewController.h"
#import "MemoData.h"
#import "AppDelegate.h"
#import "MPEditViewController.h"
#import "WebViewController.h"
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
- (IBAction)openWeb:(id)sender {
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.navigationController pushViewController:webViewController animated:YES];
}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//    [appDelegate readMemoFromDatabase];
//
//    self.title = @"MemoPad";
//
//    UIBarButtonItem *btnWrite = [[UIBarButtonItem alloc] initWithTitle:@"Write" style:UIBarButtonItemStylePlain target:self action:@selector(writeMemo)];
//    self.navigationItem.rightBarButtonItem = btnWrite;
//
//
//}




- (IBAction)changeFontSize:(id)sender {
    int fontSizeValue = self.sliderFontSize.value;
    self.tvContent.font = [UIFont fontWithName:@"Helvetica" size:fontSizeValue];
}


- (void)writeMemo:(id)acction {}

- (IBAction)editMemo:(id)sender {
    MPEditViewController *editController = [[MPEditViewController alloc] initWithNibName:@"MPEditViewController" bundle:nil];
    [self.navigationController presentModalViewController:editController animated:YES];
}




// 최근에는 UIAlertView가 사라졌어요!
//- (IBAction)deleteMemo:(id)sender {
//    UIAlertView* alertView;
//    alertView = [[UIAlertView alloc] initWithTitle:@"MemoPad" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
//    [alertView setMessage:@"Do you want to delete the memo?"];
//    [alertView show];
//}


- (IBAction)deleteMemo:(id)sender {
    // UIAlertController 인스턴스 생성
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Memo"
                                                                             message:@"Do you want to delete this memo?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    // 'Yes' 액션 추가
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate deleteMemoFromDatabase];
        [self.navigationController popViewControllerAnimated:YES];
    }];

    // 'No' 액션 추가
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

    // 액션을 AlertController에 추가
    [alertController addAction:yesAction];
    [alertController addAction:noAction];

    // AlertController 표시
    [self presentViewController:alertController animated:YES completion:nil];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appDelegate deleteMemoFromDatabase];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
