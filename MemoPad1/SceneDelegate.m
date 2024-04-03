#import "SceneDelegate.h"
#import "MPMasterViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    UIWindowScene * windowScene = (UIWindowScene*)scene;
    _window = [[UIWindow alloc]initWithFrame:windowScene.coordinateSpace.bounds];
    MPMasterViewController *masterViewController = [[MPMasterViewController alloc] initWithNibName:@"MPMasterViewController" bundle:nil];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    [_window makeKeyAndVisible];
    _window.windowScene = windowScene;
    
//    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = navController;
//
}
- (void)sceneDidDisconnect:(UIScene *)scene {
}
- (void)sceneDidBecomeActive:(UIScene *)scene {
}
- (void)sceneWillResignActive:(UIScene *)scene {
}
- (void)sceneWillEnterForeground:(UIScene *)scene {
}
- (void)sceneDidEnterBackground:(UIScene *)scene {
}


@end
