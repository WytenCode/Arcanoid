//
//  LowerGamerView.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaygroundViewController.h"

@interface LowerGamerView : UIView <GamerDelegate>

@property (nonatomic, weak) id<BallDelegate> delegate;

-(void)makeGamerMoveToPoint:(CGFloat) targetPointX;
-(BOOL)checkGamerIntersect;

@end
