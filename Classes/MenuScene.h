//
//  MenuScene.h
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/20.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "chipmunk.h" //=> 追加


@interface MenuScene : Scene {
}

@end

@interface MenuLayer : Layer {
}

- (void)startGame:(id)sender;
- (void)helloEvent:(id)sender;
- (void)tictactoe:(id)sender;
- (void)help:(id)sender;

@end
