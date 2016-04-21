//
//  GameScene.m
//  BouncingBall
//
//  Created by Alexey Huralnyk on 4/21/16.
//  Copyright (c) 2016 Alexey Huralnyk. All rights reserved.
//

#import "GameScene.h"

static const uint32_t CATEGORY_FENCE     = 0x1 << 0;
static const uint32_t CATEGORY_BALL      = 0x1 << 1;

@interface GameScene () <SKPhysicsContactDelegate>

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = CATEGORY_FENCE;
    self.physicsBody.contactTestBitMask = CATEGORY_BALL;
    self.physicsWorld.contactDelegate = self;
    
    
    // Setup the ball
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.position = CGPointMake(ball.size.width + 2, self.size.height - ball.size.height / 2 - 2);
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width / 2.0];
    ball.physicsBody.categoryBitMask = CATEGORY_BALL;
    ball.physicsBody.contactTestBitMask = CATEGORY_FENCE;
    ball.physicsBody.dynamic = YES;
    ball.physicsBody.affectedByGravity = YES;
    ball.physicsBody.allowsRotation = YES;
    ball.physicsBody.mass = 3.0;
    ball.physicsBody.friction = 0.1;
    ball.physicsBody.linearDamping = 0.1;
    ball.physicsBody.restitution = 0.9;
    ball.physicsBody.angularVelocity = 1.0;
    ball.physicsBody.velocity = CGVectorMake(200, 20);
    
    [self addChild:ball];
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


#pragma mark - SKPhysicsContactDelegate
#

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    
    SKAction *playBounceSound = [SKAction playSoundFileNamed:@"bounce" waitForCompletion:NO];
    
    NSString *dirtPath = [[NSBundle mainBundle] pathForResource:@"Dirt" ofType:@"sks"];
    SKEmitterNode *dirt = [NSKeyedUnarchiver unarchiveObjectWithFile:dirtPath];
    dirt.position = contact.contactPoint;
    
    SKAction *emitDirt = [SKAction runBlock:^{
        [self addChild:dirt];
    }];
    
    SKAction *groupAction = [SKAction group:@[playBounceSound, emitDirt]];
    
    [self runAction:groupAction];
}

- (void)didEndContact:(SKPhysicsContact *)contact {
}

@end
