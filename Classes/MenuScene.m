//
//  MenuScene.m
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/20.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "MenuScene.h"
#import "GameScene.h"
#import "HelloEventScene.h"
#import "TicTacToeScene.h"

@implementation MenuScene

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // prefetch sound resources
        SimpleAudioEngine *audioEngine = [SimpleAudioEngine sharedEngine];
        [audioEngine preloadEffect:@"bell.aif"];
        [audioEngine preloadEffect:@"gong.aif"];
        
        Sprite* bg = [Sprite spriteWithFile:@"menu.png"];
        [bg setPosition:cpv(240,160)];
        [self addChild:bg z:0];
        [self addChild:[MenuLayer node] z:1];
    }
    CCLOG( @"Menu Scene is created!!" );
    return self;
}

@end

@implementation MenuLayer

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [MenuItemFont setFontSize:20];
        [MenuItemFont setFontName:@"Helvetica"];
        MenuItem *start = [MenuItemFont itemFromString:@"Start Game" 
                                                target:self
                                              selector:@selector(startGame:)];
        MenuItem *helloEvent = [MenuItemFont itemFromString:@"Hello Event"
                                                     target:self
                                                   selector:@selector(helloEvent:)];
        MenuItem *tictactoe = [MenuItemFont itemFromString:@"Tic Tac Toe"
                                                     target:self
                                                   selector:@selector(tictactoe:)];
        MenuItem *help = [MenuItemFont itemFromString:@"Help" 
                                               target:self
                                             selector:@selector(help:)];
        Menu *menu = [Menu menuWithItems:start, helloEvent, tictactoe, help, nil];
        [menu alignItemsVerticallyWithPadding:12.0];
        [self addChild:menu];
    }
    return self;
}

- (void)startGame:(id)sender
{
    CCLOG(@"StartGame");
    SimpleAudioEngine *audioEngine = [SimpleAudioEngine sharedEngine];
    [audioEngine playEffect:@"gong.aif"];
    GameScene* scene = [GameScene node];
    TransitionScene *transition = [FadeTransition transitionWithDuration:0.5 scene:scene withColor:ccWHITE];
    [[Director sharedDirector] replaceScene:transition];
}

- (void)helloEvent:(id)sender
{
    CCLOG(@"HelloEvent");
    SimpleAudioEngine *audioEngine = [SimpleAudioEngine sharedEngine];
    [audioEngine playEffect:@"gong.aif"];
    HelloEventScene *scene = [HelloEventScene node];
    TransitionScene *transition = [FadeTransition transitionWithDuration:0.5 scene:scene withColor:ccWHITE];
    [[Director sharedDirector] replaceScene:transition];
}

- (void)tictactoe:(id)sender
{
    CCLOG(@"TicTacToe");
    SimpleAudioEngine *audioEngine = [SimpleAudioEngine sharedEngine];
    [audioEngine playEffect:@"gong.aif"];
    TicTacToeScene *scene = [TicTacToeScene node];
    TransitionScene *transition = [FadeTRTransition transitionWithDuration:1.0 scene:scene];
    [[Director sharedDirector] replaceScene:transition];
}

- (void)help:(id)sender
{
    CCLOG(@"Help");
}

@end
