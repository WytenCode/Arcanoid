//
//  PlaygroundView.m
//  arcanoidProj
//
//  Created by Владимир on 17/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "PlaygroundView.h"
#import "UpperGamerView.h"
#import "LowerGamerView.h"
#import "GameCountDownLabel.h"
#import "BallView.h"

@interface PlaygroundView()

@property (nonatomic, strong) UpperGamerView *highPlayer;
@property (nonatomic, strong) LowerGamerView *lowPlayer;
@property (nonatomic, strong) GameCountDownLabel *myCountLabel;
@property (nonatomic, strong) BallView *myBallView;

// параметры сложности
@property (nonatomic, assign) CGFloat startDifficulty;
@property (nonatomic, assign) BOOL startSpeedUp;

@end

@implementation PlaygroundView

-(void)dealloc
{
    [self.myBallView stopBallViewMovement];
    [self.myCountLabel stopTimer];
    [self.highPlayer removeFromSuperview];
    [self.lowPlayer removeFromSuperview];
    [self.myCountLabel removeFromSuperview];
    [self.myBallView removeFromSuperview];
}

-(id)initWithFrame:(CGRect)frame
{
    
    self.startSpeedUp = NO;
    self.startDifficulty = 1.0;
    
    self = [super initWithFrame:frame];
    UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 1.0f, self.bounds.size.height)];
    leftBorder.backgroundColor = [UIColor blackColor];
    [self addSubview:leftBorder];
    
    // права граница игрового поля
    UIView *rightBorder = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width, self.bounds.origin.y, 1.0f, self.bounds.size.height)];
    rightBorder.backgroundColor = [UIColor blackColor];
    [self addSubview:rightBorder];
    
    [self setupLowerPlayer];
    
    return self;
}



-(void)setupUpperPlayerWithDifficulty:(CGFloat)difficulty
{
    self.highPlayer = [[UpperGamerView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + (self.bounds.size.width/2) - 40.0f, self.bounds.origin.y + 1.0f , 80.0f, 5.0f)];
    
    [self.highPlayer setDifficulty:difficulty];
    [self addSubview:self.highPlayer];
}

-(void)setupLowerPlayer
{
    self.lowPlayer = [[LowerGamerView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + (self.bounds.size.width/2) - 40.0f, self.bounds.origin.y + self.bounds.size.height - 6.0f, 80.0f, 5.0f)];
    [self addSubview:self.lowPlayer];
}

-(void)setupGameCountDownLabel
{
    self.myCountLabel = [[GameCountDownLabel alloc] initWithFrame:CGRectMake(self.center.x - 40.0f, (self.frame.size.height/2) - 40.0f, 40, 40)];
    self.myCountLabel.delegate = self;
    [self addSubview:self.myCountLabel];
    [self.myCountLabel startCountdown];
}

-(void)setupNewBallViewWithDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    self.myBallView = [[BallView alloc] initWithFrame:CGRectMake(self.center.x - 20.0f, (self.frame.size.height/2) - 20.0f, 20, 20)];
    [self.myBallView setDifficulty:difficulty ballSpeedUp:ballSpeedUp];
    [self addSubview:self.myBallView];
    self.highPlayer.delegate = self.myBallView;
    self.lowPlayer.delegate = self.myBallView;
    self.myBallView.topDelegate = self.highPlayer;
    self.myBallView.bottomDelegate = self.lowPlayer;
    self.myBallView.pgDelegate = self;
    [self.myBallView startBallViewMovement];
}

#pragma mark - PlaygroundDelegate
-(void)gotRoundWinnerName:(NSString *) playerPos
{
    [self.pgDelegate gotRoundWinnerName:playerPos];
}

#pragma mark - PlaygroundMoveDelegate

-(void)playerTouchMoveWith:(CGFloat) targetX
{
    if (self.myBallView.isMoving)
        [self.lowPlayer makeGamerMoveToPoint:targetX];
}

-(void)startWithWithDifficulty:(CGFloat)difficulty ballSpeeUp:(BOOL)ballSpeedUp
{
    self.startSpeedUp = ballSpeedUp;
    self.startDifficulty = difficulty;
    [self setupUpperPlayerWithDifficulty:difficulty];
    [self setupGameCountDownLabel];
}

-(void)makePause
{
    [self.myBallView stopBallViewMovement];
    [self.myCountLabel stopTimer];
    [self.myCountLabel removeFromSuperview];
}

-(void)resumeFromPause
{
    [self setupGameCountDownLabel];
}

#pragma mark - CountDownDelegate
-(void)refreshCountdownData
{
    [self.myCountLabel setNeedsDisplay];
}

-(void)continueGame
{
    [self.myCountLabel removeFromSuperview];
    if (self.myBallView != nil)
    {
        [self.myBallView startBallViewMovement];
        return;
    }
    [self setupNewBallViewWithDifficulty:self.startDifficulty ballSpeedUp:self.startSpeedUp];
}

@end
