//
//  Cocos2DTestAppDelegate.m
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/20.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "Cocos2DTestAppDelegate.h"

@implementation Cocos2DTestAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    UIWindow* window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [window setUserInteractionEnabled: YES];
    [window setMultipleTouchEnabled: YES];
    [[Director sharedDirector ] setDeviceOrientation:CCDeviceOrientationLandscapeRight];
    [[Director sharedDirector ] attachInWindow:window];
    
    [window makeKeyAndVisible];
    
    MenuScene* ms = [MenuScene node];
    [[Director sharedDirector] runWithScene:ms];
}

@end
