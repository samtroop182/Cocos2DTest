//
//  GameScene.m
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/20.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "GameScene.h"
#import "MenuScene.h"

@implementation GameScene

-(id) init
{
	if(self = [super init])
	{
        // cpv = cpVect = Chipmunk vector
		Sprite* bg = [Sprite spriteWithFile:@"game.png"];
		[bg setPosition:cpv(240,160)];
		[self addChild:bg z:0];
		[self addChild:[GameLayer node] z:1];
	}
	return self;
}

@end


@implementation GameLayer

- (id)init
{
    if(self = [super init])
	{
        CGSize size = [[Director sharedDirector] winSize];
        Sprite *ship = [Sprite spriteWithFile:@"ship.png"];
        ship.position = ccp(0, 50);
        [self addChild:ship z:1];
        
        id rotateAction = [RotateBy actionWithDuration:4 angle:180*4];
        id jumpAction = [JumpBy actionWithDuration:4 position:ccp(size.width, 0) height:100 jumps:4];
        id fordward = [Spawn actions:rotateAction, jumpAction, nil];
        id backwards = [fordward reverse];
        id sequence = [Sequence actions:fordward, backwards, nil];
        id repeat = [Repeat actionWithAction:sequence times:2];
        [ship runAction:repeat];
		isTouchEnabled = YES;
	}
	return self;
}

- (BOOL)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent *)event
{
	MenuScene* ms = [MenuScene node];
	[[Director sharedDirector] replaceScene:ms];
	return kEventHandled;
}

@end
