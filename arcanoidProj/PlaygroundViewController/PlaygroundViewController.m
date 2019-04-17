//
//  PlaygroundViewController.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "PlaygroundViewController.h"
#import "UpperGamerView.h"
#import "LowerGamerView.h"
#import "GameCountDownLabel.h"
#import "BallView.h"

static const NSInteger scoreToWin = 3;

@interface PlaygroundViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) PlaygroundView *myPlaygroundView;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UILabel *winnerLabel;
@property (nonatomic, assign) NSInteger scoreUp;
@property (nonatomic, assign) NSInteger scoreDown;

// параметры сложности
@property (nonatomic, assign) CGFloat startDifficulty;
@property (nonatomic, assign) BOOL startSpeedUp;

@end

@implementation PlaygroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    self.startSpeedUp = NO;
    self.startDifficulty = 1.0;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.myPlaygroundView != nil)
    {
        [self.moveDelegate makePause];
        [self.moveDelegate resumeFromPause];
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.moveDelegate makePause];
    if (self.winnerLabel != nil)
    {
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:NO];
    }
}

-(void)setupPlaygroundViewWithDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    self.myPlaygroundView = [[PlaygroundView alloc] initWithFrame:CGRectMake(20, 60, self.view.frame.size.width - 40, self.view.frame.size.height - 120)];
    [self.view addSubview:self.myPlaygroundView];
    self.moveDelegate = self.myPlaygroundView;
    self.myPlaygroundView.pgDelegate = self;
    [self.moveDelegate startWithWithDifficulty:difficulty ballSpeeUp:ballSpeedUp];
}

-(void)prepareScoreLabel
{
    self.scoreUp = 0;
    self.scoreDown = 0;
    self.scoreLabel = [UILabel new];
    self.scoreLabel.text = [NSString stringWithFormat:@"Player  %ld | %ld  Computer", self.scoreDown, self.scoreUp];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scoreLabel];
    NSLayoutConstraint *labelLeft = [self.scoreLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0f];
    NSLayoutConstraint *labelRight = [self.scoreLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0f];
    NSLayoutConstraint *labelUp = [self.scoreLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30.0f];
    NSLayoutConstraint *labelHeight = [self.scoreLabel.heightAnchor constraintEqualToConstant:20.0f];
    [NSLayoutConstraint activateConstraints:@[ labelLeft, labelRight, labelUp, labelHeight]];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint  point = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(self.myPlaygroundView.frame, point))
        [self.moveDelegate playerTouchMoveWith:point.x];
    
}

-(void)paintVictory
{
    [self.scoreLabel removeFromSuperview];
    self.tabBarItem.title = nil;
    self.tabBarItem.image = nil;
    self.scoreLabel = nil;
    
    self.winnerLabel = [UILabel new];
    CGRect winnerLabelRect = CGRectMake(self.view.center.x - 80.0f, self.view.center.y - 30.0f, 160.0f, 30.0f);
    self.winnerLabel.frame = winnerLabelRect;
    self.winnerLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.scoreUp == scoreToWin)
    {
        self.winnerLabel.text = @"Computer wins!";
        self.winnerLabel.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.winnerLabel.backgroundColor = [UIColor greenColor];
        self.winnerLabel.text = @"Player wins!";
    }
    
    [self.view addSubview:self.winnerLabel];
    [self.gameObserverDelegate gameOff];
}

-(void)clearViews
{
    [self.myPlaygroundView removeFromSuperview];
    self.myPlaygroundView = nil;
}

#pragma mark - PrefDelegate
-(void)startGameWith:(CGFloat)difficulty speedUp:(BOOL)speedUp
{
    if (self.winnerLabel != nil)
    {
        [self.winnerLabel removeFromSuperview];
        self.winnerLabel = nil;
    }
    
    if (self.myPlaygroundView != nil)
    {
        [self clearViews];
        [self.scoreLabel removeFromSuperview];
        self.scoreLabel = nil;
    }
    
    [self.gameObserverDelegate gameOn];
    self.tabBarController.selectedViewController = self;
    self.tabBarItem.title = @"Игра";
    self.tabBarItem.image = [UIImage imageNamed:@"Hulk"];
    self.startDifficulty = difficulty;
    self.startSpeedUp = speedUp;
    [self prepareScoreLabel];
    [self setupPlaygroundViewWithDifficulty:difficulty ballSpeedUp:speedUp];
}

#pragma mark - PlaygroundDelegate
-(void)gotRoundWinnerName:(NSString *) playerPos
{
    // останавливаем мяч, раунд окончен
    if ([playerPos  isEqual: @"Up"])
    {
        // мяч попал по низу игрового поля, очко верхнему игроку
        self.scoreUp += 1;
    }
    else
    {
        // мяч попал по верху игрового поля, очко нижнему игроку
        self.scoreDown += 1;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Player  %ld | %ld  Computer", self.scoreDown, self.scoreUp];
    sleep(1);
    [self clearViews];
    if ((self.scoreUp >= self.scoreDown ? self.scoreUp : self.scoreDown) == scoreToWin)
    {
        [self paintVictory];
        return;
    }
    [self setupPlaygroundViewWithDifficulty:self.startDifficulty ballSpeedUp:self.startSpeedUp];
}

@end

