//
//  UpperGamerView.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "UpperGamerView.h"

static const CGFloat minCompare = 0.000000001f;

@interface UpperGamerView ()

@property (nonatomic ,assign) CGFloat moveSpeed;

@end

@implementation UpperGamerView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.moveSpeed = 0.5f;
    self.backgroundColor = [UIColor blackColor];
    return self;
}

-(void)setDifficulty:(CGFloat)difficulty
{
    self.moveSpeed = 0.5f + (3.0f * (difficulty - 1.0f));
}


#pragma mark - GamerDelegate

-(BOOL)checkGamerIntersect
{
    CGRect tmpRect = self.delegate.giveBallDelegateFrame;
    CGPoint tmpPoint = self.delegate.giveBallDelegateCenter;
    CGFloat tmpFloat = self.delegate.giveBallDelegateRadius;
    
    if (CGRectIntersectsRect(tmpRect, self.frame))
    {
        // левый нижний угол плашки компа
        CGPoint leftComputerPoint = CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
        // правый нижний угол плашки компа
        CGPoint rightComputerPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
        
        CGFloat dist = sqrtf(powf(tmpPoint.x - leftComputerPoint.x, 2.0f) + powf(tmpPoint.y - leftComputerPoint.y, 2.0f));
        CGFloat dist1 = sqrtf(powf(tmpPoint.x - rightComputerPoint.x, 2.0f) + powf(tmpPoint.y - rightComputerPoint.y, 2.0f));
        
        // расстояние от углов больше радиуса и шар между углов - зеркальное отражение
        if ((dist > tmpFloat) && (tmpPoint.x > leftComputerPoint.x) && (dist1 > tmpFloat) && (tmpPoint.x < rightComputerPoint.x))
        {
            [self.delegate changeBallDelegateYDirection];
            return YES;
        }
        
        // угол внутри , но конец плашки не с той же стороны от центра шара, что и центр плашки - зеркальное отражение
        if (((dist < tmpFloat) && (tmpPoint.x > leftComputerPoint.x)) || ((dist1 < tmpFloat) && (tmpPoint.x < rightComputerPoint.x)))
        {
            [self.delegate changeBallDelegateYDirection];
            return YES;
        }
        
        if ((dist < tmpFloat) && (tmpPoint.x < leftComputerPoint.x))
        {
            if (!self.delegate.ballDelegateMovingLeft)
            {
                [self.delegate changeBallDelegateXDirection];
                [self.delegate changeBallDelegateYDirection];
                return YES;
            }
            else
            {
                [self.delegate changeBallDelegateYDirection];
                return YES;
            }
        }
        
        if ((dist1 < tmpFloat) && (tmpPoint.x > rightComputerPoint.x))
        {
            if (self.delegate.ballDelegateMovingLeft)
            {
                [self.delegate changeBallDelegateXDirection];
                [self.delegate changeBallDelegateYDirection];
                return YES;
            }
            else
            {
                [self.delegate changeBallDelegateYDirection];
                return YES;
            }
        }
    }
    return NO;
}

-(void)initGamerMove
{
    CGPoint tmpPoint = self.delegate.giveBallDelegateCenter;
    
    if (tmpPoint.x == self.center.x)
        return;
    if (tmpPoint.x <= self.frame.origin.x)
        [self makeComputerMoveLeftOn:ABS(self.frame.origin.x - tmpPoint.x) + 1.0f];
    else if (tmpPoint.x >= self.frame.origin.x + self.frame.size.width)
        [self makeComputerMoveRightOn:ABS(tmpPoint.x - self.bounds.origin.x - self.bounds.size.width) + 1.0f];
}

-(void)makeComputerMoveLeftOn:(CGFloat) diff
{
    CGFloat realDiff;
    if (diff - self.moveSpeed > minCompare)
        realDiff = self.moveSpeed;
    else
        realDiff = diff;
    
    CGFloat maxDistLeft = self.frame.origin.x;
    if (realDiff > maxDistLeft)
        realDiff = maxDistLeft;
    self.center = CGPointMake(self.center.x - realDiff, self.center.y);
}

-(void)makeComputerMoveRightOn:(CGFloat) diff
{
    CGFloat realDiff;
    if (diff - self.moveSpeed > minCompare)
        realDiff = self.moveSpeed;
    else
        realDiff = diff;
    
    CGFloat rightPlayground = self.superview.frame.origin.x + self.superview.frame.size.width;
    CGFloat rightComputerView = self.frame.origin.x + self.frame.size.width;
    
    CGFloat maxDistRight = rightPlayground - rightComputerView;
    if (realDiff > maxDistRight)
        realDiff = maxDistRight;
    self.center = CGPointMake(self.center.x + realDiff, self.center.y);
}

@end

