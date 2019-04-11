//
//  PlaygroundViewController.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@protocol CountDownDelegate <NSObject>
-(void)continueGame;
-(void)refreshCountdownData;
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

@protocol PlaygroundDelegate <NSObject>
-(void)gotRoundWinnerName:(NSString *) playerPos;
@end



@interface PlaygroundViewController : UIViewController <PrefDelegate, UITabBarDelegate, CountDownDelegate, PlaygroundDelegate>


@end


