//
//  GameCountDownLabel.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "GameCountDownLabel.h"

@interface GameCountDownLabel()

@property (nonatomic, assign) NSInteger countDownMax;
@property (nonatomic, assign) NSInteger curTime;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation GameCountDownLabel

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.countDownMax = 3;
    self.curTime = self.countDownMax;
    self.textAlignment = NSTextAlignmentCenter;
    [self setFont:[UIFont systemFontOfSize:50.0f]];
    self.text = [NSString stringWithFormat:@"%ld", self.countDownMax];
    return self;
}


-(void)startCountdown
{
    self.curTime = self.countDownMax;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(makingCountDown) userInfo:nil repeats:YES];
}

-(void)makingCountDown
{
    self.curTime --;
    if (self.curTime == 0)
    {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        [self.delegate continueGame];
    }
    self.text = [NSString stringWithFormat:@"%ld", self.curTime];
    [self.delegate refreshCountdownData];
}


@end

