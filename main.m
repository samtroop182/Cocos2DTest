//
//  main.m
//  SampleGame
//
//  Created by Masashi Ono on 09/07/20.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
//    int retVal = UIApplicationMain(argc, argv, nil, nil);
	int retVal = UIApplicationMain(argc, argv, nil, @"Cocos2DTestAppDelegate");
    [pool release];
    return retVal;
}
