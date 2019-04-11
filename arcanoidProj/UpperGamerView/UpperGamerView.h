//
//  UpperGamerView.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaygroundViewController.h"

@interface UpperGamerView : UIView <GamerDelegate>

@property (nonatomic, weak) id<BallDelegate> delegate;

-(void)setDifficulty:(CGFloat)difficulty;
-(BOOL)checkGamerIntersect;

@end
