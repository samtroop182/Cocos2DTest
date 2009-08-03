//
//  HelloEventScene.m
//  Cocos2DTest
//
//  Created by Masashi Ono on 09/07/22.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "HelloEventScene.h"


@implementation HelloEventScene

-(id) init
{
    if (self = [super init])
    {
        [self addChild:[HelloEventLayer node] z:1];
    }
    return self;
}

@end

@implementation HelloEventLayer

- (id)init
{
    if (self = [super init])
    {
        self.isTouchEnabled = YES;
        self.isAccelerometerEnabled = YES;
        
        Label *label = [Label labelWithString:@"Abesi" fontName:@"Marker Felt" fontSize:64.0];
        CGSize size = [[Director sharedDirector] winSize];
        label.position = ccp(size.width/2, size.height/2);
        [self addChild:label];
        
        Sprite *sprite = [Sprite spriteWithFile:@"ship.png"];
        sprite.position = ccp(50, 50);
        [self addChild:sprite z:1 tag:1];
    }
    return self;
}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];
        CocosNode *sprite = [self getChildByTag:1];
        [sprite stopAllActions];
        [sprite runAction:[MoveTo actionWithDuration:1 position:convertedPoint]];
        return kEventHandled;
    }
    
    return kEventIgnored;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    CocosNode *sprite = [self getChildByTag:1];
    
    CGPoint rawPoint = ccp(acceleration.x, acceleration.y);
    CCLOG(@"rawPoint (%f, %f)", acceleration.x, acceleration.y);
    
    // convert accelomator according to the current orientation
    ccDeviceOrientation orientation = [Director sharedDirector].deviceOrientation;
    CGPoint convertedPoint = CGPointZero;
    switch (orientation) {
        case CCDeviceOrientationLandscapeRight:
            convertedPoint = ccp((float)rawPoint.y, (float)-rawPoint.x);
            break;
        case CCDeviceOrientationLandscapeLeft:
            convertedPoint = ccp(-(float)rawPoint.y, (float)rawPoint.x);
            break;
        case CCDeviceOrientationPortrait:
            convertedPoint = rawPoint;
            break;
        case CCDeviceOrientationPortraitUpsideDown:
            convertedPoint = ccp(-(float)rawPoint.x, (float)-rawPoint.y);
            break;
        default:
            break;
    }
    
    CCLOG(@"convertedPoint (%f, %f)", convertedPoint.x, convertedPoint.y);
    sprite.rotation = (float)CC_RADIANS_TO_DEGREES(atan2f(convertedPoint.x, convertedPoint.y));
    sprite.scale = 0.5f + sqrtf((powf(convertedPoint.x, 2) + powf(convertedPoint.y, 2)));
}

@end

