//
//  TicTacToeScene.m
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/27.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "TicTacToeScene.h"
#import "MenuScene.h"


@implementation TicTacToeScene

-(id) init
{
    if(self = [super init])
    {
        // add background layer
        CGSize size = [[Director sharedDirector] winSize];
        Layer* bg = [ColorLayer layerWithColor:0xffffffff width:size.width height:size.height];
        [bg setPosition:ccp(0, 0)];
        [self addChild:bg z:0];
        
        // create the game board sprite and add it
//        CGSize size = [[Director sharedDirector] winSize];
        Sprite *board = [Sprite spriteWithFile:@"board.png"];
        board.position = ccp(size.width/2, size.height/2);
        [self addChild:board z:1];
        
        // add menu item (back button)
        Label *label = [Label labelWithString:@"Back" fontName:@"Helvetica" fontSize:32.0];
        [label setRGB:0x00 :0x10 :0x99];
        MenuItem *back = [MenuItemLabel itemWithLabel:label target:self selector:@selector(back:)];
        Menu *menu = [Menu menuWithItems:back, nil];
		[menu alignItemsVertically];
        menu.position = ccp(40, 20);
		[self addChild:menu z:2];
        
        // add game board layer (pieces are placed on here)
        [self addChild:[TicTacToeLayer node] z:3];
    }
    return self;
}

- (void)back:(id)sender
{
	MenuScene* scene = [MenuScene node];
    FadeTRTransition *transition = [FadeTRTransition transitionWithDuration:1.0 scene:scene];
	[[Director sharedDirector] replaceScene:transition];
}

@end

@implementation TicTacToeLayer

- (id)init
{
    if(self = [super init])
	{
        // enable touches and accelerometer
		isTouchEnabled = YES;
        isAccelerometerEnabled = YES;
        
        // set current turn to maru
        currentTurn = kCurrentTurnMaru;
        
        // set initial accelerometer value
        lastAccerelometerVector = CGPointZero;
        

	}
	return self;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];
        
        // Create piece sprite and add it with tag "Moving"(According to current turn)
        Sprite *piece = nil;
        switch (currentTurn) {
            case kCurrentTurnMaru:
                piece = [Sprite spriteWithFile:@"maru.png"];
                CCLOG(@"Piece=%p", piece);
                piece.position = convertedPoint;
                [self addChild:piece z:0 tag:kPieceMoving];
                break;
            case kCurrentTurnBatu:
                piece = [Sprite spriteWithFile:@"batu.png"];
                CCLOG(@"Piece=%p", piece);
                piece.position = convertedPoint;
                [self addChild:piece z:0 tag:kPieceMoving];
                break;
            default:
                break;
        }
        
        // add particle effect
        ParticleSystem *particle = [[[ParticleExplosion alloc] init] autorelease];
        particle.position = convertedPoint;
        [self addChild:particle z:100];
        
        // play sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"bell.aif"];
        
        return kEventHandled;
    }
    
    return kEventIgnored;
}

- (BOOL)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];
        
        // move the piece "moving"
        Sprite *piece = (Sprite *)[self getChildByTag:kPieceMoving];
        piece.position = convertedPoint;
        
        return kEventHandled;
    }
    return kEventIgnored;
}

- (BOOL)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];
        
        // settle the piece "moving"
        Sprite *piece = (Sprite *)[self getChildByTag:kPieceMoving];
        piece.position = convertedPoint;
        piece.tag = kPieceSettled;
        
        // ends current turn, pass to the next player
        switch (currentTurn) {
            case kCurrentTurnMaru:
                currentTurn = kCurrentTurnBatu;
                break;
            case kCurrentTurnBatu:
                currentTurn = kCurrentTurnMaru;
                break;
            default:
                break;
        }
        
        return kEventHandled;
    }
    return kEventIgnored;
}

- (BOOL)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        // remove the piece "moving". (do not end the current turn)
        [self removeChildByTag:kPieceMoving cleanup:YES];
        
        return kEventHandled;
    }
    return kEventIgnored;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // create raw vector and converted vector of current accelerometer value
    CGPoint rawVector = ccp(acceleration.x, acceleration.y);
    ccDeviceOrientation orientation = [Director sharedDirector].deviceOrientation;
    CGPoint convertedVector = CGPointZero;
    switch (orientation) {
        case CCDeviceOrientationLandscapeRight:
            convertedVector = ccp((float)rawVector.y, (float)-rawVector.x);
            break;
        case CCDeviceOrientationLandscapeLeft:
            convertedVector = ccp(-(float)rawVector.y, (float)rawVector.x);
            break;
        case CCDeviceOrientationPortrait:
            convertedVector = rawVector;
            break;
        case CCDeviceOrientationPortraitUpsideDown:
            convertedVector = ccp(-(float)rawVector.x, (float)-rawVector.y);
            break;
        default:
            break;
    }
    
    // determine shake gesture
    float dot = ccpDot(lastAccerelometerVector, convertedVector);
    float a = ccpLength(lastAccerelometerVector);
    float b = ccpLength(convertedVector);
    float cosTheta;
    // avoiding 0 divide. compairing float value with == is not wise though.
    if (a * b != 0.0)
    {
        cosTheta = dot / (a*b);
    }
    else
    {
        cosTheta = FLT_MAX;
    }
    float threshold = cos(CC_DEGREES_TO_RADIANS(120.0));
    // detect shake when:
    // 1. vector angles are greater than 120.0 degrees
    // 2. and both vectors have lenth of 0.6
    if ((cosTheta < threshold) && a > 0.6 && b > 0.6)
    {
        CCLOG(@"cosTheta=%f threshold=%f [shaken!]", cosTheta, threshold);
        CCLOG(@"vector length: (%f, %f)", a, b);
        
        // remove all pieces from the board
        [self removeAllChildrenWithCleanup:YES];
    }
    
    // keep current vector for next calculation
    lastAccerelometerVector = convertedVector;
}

@end
