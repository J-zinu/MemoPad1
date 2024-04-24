//
//  MemoData.h
//  Memopad
//
//  Created by JinWoo Jeong on 4/1/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoData : NSObject {
    NSInteger mIndex;
    NSString *mTitle;
    NSString *mContent;
    NSString *mDate;
}


@property (nonatomic, assign) NSInteger mIndex;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mContent;
@property (nonatomic, retain) NSString *mDate;

-(id)initWithData:(NSInteger)pIndex Title:(NSString*)pTitle
      Content:(NSString*)pContent Date:(NSString*)pDate;

@end

NS_ASSUME_NONNULL_END
