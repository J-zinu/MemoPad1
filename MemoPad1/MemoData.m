//
//  MemoData.m
//  Memopad
//
//  Created by JinWoo Jeong on 4/1/24.
//

#import "MemoData.h"


@implementation MemoData
@synthesize mIndex;
@synthesize mTitle;
@synthesize mContent;
@synthesize mDate;
-(id)initWithData:(NSInteger)pIndex Title:(NSString *)pTitle Content:(NSString *)pContent Date:(NSString *)pDate{
    self.mIndex = pIndex;
    self.mTitle = pTitle;
    self.mContent = pContent;
    self.mDate = pDate;
    return self;
}

- (void)dealloc {
    // ARC가 있어서 메모리 해제를 굳이 사용을 안해도 된다고함
//    if(mTitle) {
//        [mTitle release];
//    }
//    if(mContent) {
//        [mContent release];
//    }
//    if (mDate){
//        [mDate release];
//    }
//    [super dealloc];
}


@end
