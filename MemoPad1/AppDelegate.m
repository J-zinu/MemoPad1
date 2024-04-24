//
//  AppDelegate.m
//  Memopad
//
//  Created by JinWoo Jeong on 3/29/24.
//

#import "AppDelegate.h"
#import "MemoData.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize DBName;
@synthesize DBPath;
@synthesize DBData;
@synthesize isFirstTimeAccess;
@synthesize currentMemoSqlIndex;
@synthesize currentMemoRowIndex;



/*
 *application didFinishLaunchingWithOptions은 앱이 실행되자마자 최초로 실행되는 코드임
 *앱의 초기화 작업을 하기에 좋다.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.isFirstTimeAccess = TRUE;
    
    NSArray *documentPaths =
            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    
    
    
//z
    self.DBName = @"Memopad.db";
    self.DBPath = [documentsDir stringByAppendingPathComponent:self.DBName];
    [self checkAndCreateDatabase];
//
//    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
//    MPMasterViewController *masterViewController = [[MPMasterViewController alloc] initWithNibName:@"MPMasterViewController" bundle:nil];
//
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
//
//    self.window.rootViewController = navController;
//
//    [self.window makeKeyAndVisible];
//
    [self readMemoFromDatabase];
    return YES;
    
}



- (void) checkAndCreateDatabase {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: self.DBPath]) {
        return;
    }
    else {
        NSString *databasePathFormApp = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self.DBName];
        [fileManager copyItemAtPath:databasePathFormApp toPath:self.DBPath error:nil];
        // ARC 작동하니까 굳이 릴리즈 처리 안해도 되는듯?
//        [fileManager release];
       
    }
}


- (void) readMemoFromDatabase {
    sqlite3 *database;
    if(self.isFirstTimeAccess == TRUE) {
        self.DBData = [[NSMutableArray alloc] init];
        self.isFirstTimeAccess = FALSE;
    }
    else {
        [self.DBData removeAllObjects];
    }
    if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
//        const char *sqlStatement = "SELECT * FROM tblMemoPad ORDER BY MP_INDEX DESC";
        const char *sqlStatement = "SELECT * FROM tblMemoPad ORDER BY MP_INDEX DESC";

        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL)
           == SQLITE_OK){
            while (sqlite3_step(compiledStatement) == SQLITE_ROW){
                NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);
                NSString *aTitle = [NSString stringWithUTF8String:(char * )sqlite3_column_text(compiledStatement, 1)];
                NSString *aContent = [NSString stringWithUTF8String:(char * )sqlite3_column_text(compiledStatement, 2)];
                NSString *aDate = [NSString stringWithUTF8String:(char * )sqlite3_column_text(compiledStatement, 3)];
            
                
                MemoData *md = [[MemoData alloc] initWithData:aIndex Title:aTitle Content:aContent Date:aDate];
            
                NSLog(@"%d / %@ / %@ / @/", aIndex, aTitle, aContent, aDate);
                [self.DBData addObject:md];
                //release는 ARC떄문에 굳이 선언 안해도 됨
//                [md release];
            }
        }
        else {
            printf("could not prepare statemnt: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    
}


@end
