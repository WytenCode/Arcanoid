//
//  BallView.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolHolder.h"


@interface BallView : UIView <BallDelegate>

@property (nonatomic, weak) id<GamerDelegate> topDelegate;
@property (nonatomic, weak) id<GamerDelegate> bottomDelegate;
@property (nonatomic, weak) id<PlaygroundDelegate> pgDelegate;

-(void)setDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp;
-(void)startBallViewMovement;
-(void)stopBallViewMovement;
-(BOOL)isMoving;

@end
