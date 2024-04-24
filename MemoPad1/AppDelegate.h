//
//  AppDelegate.h
//  Memopad
//
//  Created by JinWoo Jeong on 3/29/24.
//


#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "SceneDelegate.h"

//@interface AppDelegate : UIResponder <UIApplicationDelegate> {
@interface AppDelegate : NSObject <UIApplicationDelegate> {

    
    NSString *DBName;
    NSString *DBPath;
    NSMutableArray *DBData;
    BOOL isFirstTimeAccess;
    
    NSInteger currentMemoSqlIndex;
    NSInteger currentMemoRowIndex;
    
}

@property (nonatomic, retain) NSString *DBName;
@property (nonatomic, retain) NSString *DBPath;
@property (nonatomic, retain) NSMutableArray *DBData;
@property (nonatomic, assign) BOOL isFirstTimeAccess;
@property (nonatomic, assign) NSInteger currentMemoSqlIndex;
@property (nonatomic, assign) NSInteger currentMemoRowIndex;

- (void) checkAndCreateDatabase;
- (void) readMemoFromDatabase;


@end

