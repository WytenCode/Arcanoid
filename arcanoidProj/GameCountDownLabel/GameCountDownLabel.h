//
//  GameCountDownLabel.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaygroundViewController.h"


@interface GameCountDownLabel : UILabel

-(void)startCountdown;
@property (nonatomic, weak) id<CountDownDelegate> delegate;

@end
