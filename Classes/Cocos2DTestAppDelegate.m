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
	
	// ステータスバーを消したい人は、YES
	[[UIApplication sharedApplication] setStatusBarHidden:YES];

	// Windowに関する設定
	[window setUserInteractionEnabled: YES];
	// マルチタッチを有効にする
	[window setMultipleTouchEnabled: YES];
	// 横で起動
	[[Director sharedDirector ] setDeviceOrientation:CCDeviceOrientationLandscapeRight];
	// Directorにゲームウィンドウをアタッチする
	[[Director sharedDirector ] attachInWindow:window];
	
	[window makeKeyAndVisible];
	
	/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	/* ユーザー毎の設定 */
	/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	MenuScene* ms = [MenuScene node]; // メニューシーンのノード取得
	[[Director sharedDirector] runWithScene:ms]; // Directorで再生する
}

@end
