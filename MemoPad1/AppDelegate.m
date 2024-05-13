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
                
                
//                NSString *aTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
//                NSString *aContent = [NSString stringWithUTF8String:(char * )sqlite3_column_text(compiledStatement, 2)];
//                NSString *aDate = [NSString stringWithUTF8String:(char * )sqlite3_column_text(compiledStatement, 3)];
                
                const char *titleChars = (const char *)sqlite3_column_text(compiledStatement, 1);
                NSString *aTitle = titleChars ? [NSString stringWithUTF8String:titleChars] : @"";

                const char *contentChars = (const char *)sqlite3_column_text(compiledStatement, 2);
                NSString *aContent = contentChars ? [NSString stringWithUTF8String:contentChars] : @"";

                const char *dateChars = (const char *)sqlite3_column_text(compiledStatement, 3);
                NSString *aDate = dateChars ? [NSString stringWithUTF8String:dateChars] : @"";
                
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

- (void) writeMemoToDataBaseWithTitle: (NSString*)inputTitle Content: (NSString*)inputContent{
    
    sqlite3 *database;
    
    if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES(?, ?, ?)";
        
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            
            NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
            NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
            NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
            NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
            NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
            NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
            NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
            
        
            NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@", yearOfCommonEra, monthOfYear, dayOfMonth];
            NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@", hourOfDay, minuteOfHour, secondOfMinute];
            
            
            //얻어낸 날짜와 시각 문자열들을 합쳐 최종적으로 하나의 문자열로 만든다.
            NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat];

            sqlite3_bind_text(compiledStatement, 1, [inputTitle UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [inputContent UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
            //SQL 명령을 실행한다.
            if(SQLITE_DONE != sqlite3_step(compiledStatement))
                                    NSAssert1(0, @"Error while inserting into tblMemoPad: '%s'", sqlite3_errmsg(database));
            
            sqlite3_reset(compiledStatement);
        
            sqlite3_close(database);
           }
        else {
            NSLog(@"could not prepare statemnt: %s\n", sqlite3_errmsg(database));
        }
    }
    else {
        sqlite3_close(database);
        NSAssert1(0, @"Error opening database in tblMemoPad. '%s'", sqlite3_errmsg(database));
    }
}



-(void) upDateMemoToDatabaseWithTitle:(NSString *)inputTitle Content:(NSString *)inputContent{
    
    sqlite3 *database;
    
    if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK){
        NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"UPDATE tblMemoPad SET MP_Title=?, MP_Content=?, MP_Date=? WHERE MP_Index = '%d'", self.currentMemoSqlIndex]];
        
        const char *sqlStatement = [sqlStatementNS UTF8String];
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            
            NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
            NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
            NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
            NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
            NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
            NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
            NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
            
            NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@", yearOfCommonEra, monthOfYear, dayOfMonth];
            NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@", hourOfDay, minuteOfHour, secondOfMinute];
            
            NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat];
            
            sqlite3_bind_text(compiledStatement, 1, [inputTitle UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [inputContent UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
            
            
            if(SQLITE_DONE != sqlite3_step(compiledStatement))
                                    NSAssert(0, @"Error while inserting into tblMemoPad: '%s'", sqlite3_errmsg(database));
            
            sqlite3_reset(compiledStatement);
//            sqlite3_finalize(compiledStatement);
        
            sqlite3_close(database);
            
        }
        else{
            NSLog(@"could not prepare statemnt: %s\n", sqlite3_errmsg(database));
        }
    }
    else {
        sqlite3_close(database);
        NSAssert(0, @"Error opening database in tblMemoPad. '%s'", sqlite3_errmsg(database));
    }
}

-(void) deleteMemoFromDatabase {
    sqlite3 *database;
    if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
        
//        NSString* sqlStatementNS = [[NSString alloc] initWithString: [NSString stringWithFormat:@"DELETE FROM tblMemoPad WHERE MP_Index = '%d'", self.currentMemoSqlIndex]];
        
        NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"DELETE FROM tblMemoPad WHERE MP_Index = %d", self.currentMemoSqlIndex]];

        
        const char *sqlStatement = [sqlStatementNS UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            if(SQLITE_DONE != sqlite3_step(compiledStatement))
                NSAssert1(0, @"Error while deleting from tblMemoPad: '%s'", sqlite3_errmsg(database));
        
            sqlite3_reset(compiledStatement);
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}




@end
