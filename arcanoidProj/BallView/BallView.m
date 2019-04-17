//
//  BallView.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "BallView.h"

@interface  BallView()

@property (nonatomic, strong) NSTimer *ballMovementTimer;
@property (nonatomic, assign) CGFloat moveX;
@property (nonatomic, assign) CGFloat moveY;
@property (nonatomic, assign) CGFloat moveMultiplier;
@property (nonatomic, assign) CGFloat moveMultiplierStep;
@property (nonatomic, assign) CGFloat ballRadius;

@end

@implementation BallView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blueColor];
    self.alpha = 1.0;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.ballRadius = self.frame.size.width/2;
    return self;
}

-(void)setDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    [self randomizeBallStartDirectionithDifficulty:difficulty ballSpeedUp:ballSpeedUp];
    [self normalizeBallMove];
}

// вброс мяча под случайным направлением + установка сложности для мяча
-(void)randomizeBallStartDirectionithDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    NSInteger part11 = arc4random_uniform(150) + 50;
    NSInteger part12 = arc4random_uniform(150) + 50;
    NSInteger part21 = arc4random_uniform(150) + 50;
    NSInteger part22 = arc4random_uniform(150) + 50;
    
    self.moveX = part11 * (part21 % 2 == 1 ? 1 : -1);
    self.moveY = part12 * (part22 % 2 == 1 ? 1 : -1);
    self.moveMultiplier = 0.50f;
    if (ballSpeedUp)
    {
        self.moveMultiplierStep = 0.05f + (0.1f * (difficulty - 1.0));
    }
    else
    {
        self.moveMultiplier = 0.50f + (2.00f * (difficulty - 1.0));
    }
}

-(void)normalizeBallMove
{
    if (ABS(self.moveX) / ABS(self.moveY) > 1.0f)
    {
        self.moveY /= ABS(self.moveX);
        self.moveX = 1.0f * (self.moveX > 0 ? 1 : -1);
    }
    else
    {
        self.moveX /= ABS(self.moveY);
        self.moveY = 1.0f * (self.moveY > 0 ? 1 : -1);
    }
}
-(void)startBallViewMovement
{
    self.ballMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(ballMovement) userInfo:nil repeats:YES];
}

-(void)ballMovement
{
    if (self.topDelegate.checkGamerIntersect)
    {
        self.moveMultiplier += self.moveMultiplierStep;
    }
    if (self.bottomDelegate.checkGamerIntersect)
    {
        self.moveMultiplier += self.moveMultiplierStep;
    }
    
    CAKeyframeAnimation *movAnimation = [CAKeyframeAnimation animation];
    movAnimation.keyPath = @"position";
    
    CGFloat nextX = 0.0f;
    CGFloat nextY = 0.0f;
    
    // удар об стенку
    if ((self.center.x + self.moveX + self.ballRadius > self.superview.bounds.origin.x + self.superview.bounds.size.width) || (self.center.x + self.moveX - self.ballRadius< self.superview.bounds.origin.x))
    {
        self.moveX *= -1;
    }
    
    // мяч пробил дно
    if (self.center.y + self.moveY + self.ballRadius >= self.superview.frame.size.height)
    {
        [self stopBallViewMovement];
        [self.pgDelegate gotRoundWinnerName:@"Up"];
        return;
    }
    
    // мяч пробил верх
    else if (self.center.y + self.moveY - self.ballRadius <= 0)
    {
        [self stopBallViewMovement];
        [self.pgDelegate gotRoundWinnerName:@"Down"];
        return;
    }
    
    nextX = self.center.x + (self.moveX * self.moveMultiplier);
    nextY = self.center.y + (self.moveY * self.moveMultiplier);
    
    movAnimation.values = @[@(CGPointMake(self.center.x, self.center.y)),
                            @(CGPointMake(nextX, nextY))];
    
    movAnimation.duration = 0.005;
    
    self.center = CGPointMake(nextX, nextY);
    
    movAnimation.fillMode = kCAFillModeForwards;
    movAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:movAnimation forKey:@"ballMoving"];
    [self.topDelegate initGamerMove];
}

-(void)stopBallViewMovement
{
    [self.ballMovementTimer invalidate];
    self.ballMovementTimer = nil;
}

-(BOOL)isMoving
{
    return self.ballMovementTimer != nil ? YES : NO;
}

#pragma mark - BallDelegate

-(CGRect)giveBallDelegateFrame
{
    return self.frame;
}

-(CGPoint)giveBallDelegateCenter
{
    return self.center;
}

-(CGFloat)giveBallDelegateRadius
{
    return self.ballRadius;
}

-(void)changeBallDelegateXDirection
{
    self.moveX *= -1;
}

-(void)changeBallDelegateYDirection
{
    self.moveY *= -1;
}

-(BOOL)ballDelegateMovingLeft
{
    return self.moveX <= 0 ? YES : NO;
}

@end

