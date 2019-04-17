//
//  ProtocolHolder.h
//  arcanoidProj
//
//  Created by Владимир on 17/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

@protocol InitDelegate <NSObject>
-(void)gameInitStarted;
@end

@protocol PrefDelegate <NSObject>
-(void)startGameWith:(CGFloat)difficulty speedUp:(BOOL)speedUp;
@end

@protocol BallDelegate <NSObject>
-(CGRect)giveBallDelegateFrame;
-(CGPoint)giveBallDelegateCenter;
-(CGFloat)giveBallDelegateRadius;
-(void)changeBallDelegateYDirection;
-(void)changeBallDelegateXDirection;
-(BOOL)ballDelegateMovingLeft;
@end

@protocol GamerDelegate <NSObject>
-(BOOL)checkGamerIntersect;
-(void)initGamerMove;
@end

@protocol GameObserverProtocol <NSObject>
-(void)gameOn;
-(void)gameOff;
@end

@protocol PlaygroundMoveDelegate
-(void)playerTouchMoveWith:(CGFloat) targetX;
-(void)startWithWithDifficulty:(CGFloat)difficulty ballSpeeUp:(BOOL)ballSpeedUp;
-(void)resumeFromPause;
-(void)makePause;
@end

@protocol PlaygroundDelegate <NSObject>
-(void)gotRoundWinnerName:(NSString *) playerPos;
@end

@protocol CountDownDelegate <NSObject>
-(void)continueGame;
-(void)refreshCountdownData;
@end

