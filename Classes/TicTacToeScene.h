//
//  TicTacToeScene.h
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/27.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// this definition enables type "kCurrentTurn" or "enum _kCurrentTurn"
typedef enum _kCurrentTurn {
    kCurrentTurnNone = 0,
    kCurrentTurnMaru = 1,
    kCurrentTurnBatu = 2,
} kCurrentTurn;

enum {
    kPieceMoving = 0xffffffff-1,
    kPieceSettled = 0xffffffff-2,
};


@interface TicTacToeScene : Scene {
}
@end

@interface TicTacToeLayer : Layer {
    kCurrentTurn currentTurn;
    CGPoint lastAccerelometerVector;
}
@end
