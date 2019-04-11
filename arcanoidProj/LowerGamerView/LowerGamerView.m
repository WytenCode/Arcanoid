//
//  LowerGamerView.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "LowerGamerView.h"

@interface LowerGamerView()

@end

@implementation LowerGamerView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    return self;
}

-(void)makeGamerMoveToPoint:(CGFloat) targetPointX
{
    CAKeyframeAnimation *movAnimation = [CAKeyframeAnimation animation];
    movAnimation.keyPath = @"position";
    if (targetPointX - self.superview.frame.origin.x <= (self.frame.size.width/2))
    {
        targetPointX = self.frame.size.width/2 + self.superview.frame.origin.x;
    }
    else if (self.superview.frame.origin.x + self.superview.frame.size.width - targetPointX <= (self.frame.size.width/2))
    {
        targetPointX = self.superview.frame.origin.x + self.superview.frame.size.width - (self.frame.size.width/2);
    }
    
    targetPointX -= self.superview.frame.origin.x;
    
    // все остальные случаи просто переместят плашку в нужном направлении
    movAnimation.values = @[@(CGPointMake(self.center.x, self.center.y)),
                            @(CGPointMake(targetPointX, self.center.y))];
    movAnimation.duration = 0.05;
    movAnimation.fillMode = kCAFillModeForwards;
    movAnimation.removedOnCompletion = NO;
    
    self.center = CGPointMake(targetPointX , self.center.y);
    
    [self.layer addAnimation:movAnimation forKey:@"playerMoving"];
}

#pragma mark - GamerDelegate

-(BOOL)checkGamerIntersect
{
    CGRect tmpRect = self.delegate.giveBallDelegateFrame;
    CGPoint tmpPoint = self.delegate.giveBallDelegateCenter;
    CGFloat tmpFloat = self.delegate.giveBallDelegateRadius;
    
    if (CGRectIntersectsRect(tmpRect, self.frame))
    {
        // левый верхний угол плашки игрока
        CGPoint leftPlayerPoint = CGPointMake(self.frame.origin.x, self.frame.origin.y);
        // правый верхний угол плашки игрока
        CGPoint rightPlayerPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
        
        CGFloat dist = sqrtf(powf(tmpPoint.x - leftPlayerPoint.x, 2.0f) + powf(tmpPoint.y - leftPlayerPoint.y, 2.0f));
        CGFloat dist1 = sqrtf(powf(tmpPoint.x - rightPlayerPoint.x, 2.0f) + powf(tmpPoint.y - rightPlayerPoint.y, 2.0f));
        
        // расстояние от углов больше радиуса и шар между углов - зеркальное отражение
        if ((dist > tmpFloat) && (tmpPoint.x > leftPlayerPoint.x) && (dist1 > tmpFloat) && (tmpPoint.x < rightPlayerPoint.x))
        {
            [self.delegate changeBallDelegateYDirection];
            return YES;
        }
        
        // угол внутри , но конец плашки не с той же стороны от центра шара, что и центр плашки - зеркальное отражение
        if (((dist < tmpFloat) && (tmpPoint.x > leftPlayerPoint.x)) || ((dist1 < tmpFloat) && (tmpPoint.x < rightPlayerPoint.x)))
        {
            [self.delegate changeBallDelegateYDirection];
            return YES;
        }
        
        if ((dist < tmpFloat) && (tmpPoint.x < leftPlayerPoint.x))
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
        
        if ((dist1 < tmpFloat) && (tmpPoint.x > rightPlayerPoint.x))
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
    
}

@end

