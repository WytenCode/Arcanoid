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

@property (nonatomic, strong) UIView *playgroundView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UpperGamerView *highPlayer;
@property (nonatomic, strong) LowerGamerView *lowPlayer;
@property (nonatomic, strong) GameCountDownLabel *myCountLabel;
@property (nonatomic, strong) BallView *myBallView;

@property (nonatomic, strong) UILabel *winnerLabel;
@property (nonatomic, assign) NSInteger scoreUp;
@property (nonatomic, assign) NSInteger scoreDown;

// параметры сложности
@property (nonatomic, assign) CGFloat startDifficulty;
@property (nonatomic, assign) BOOL startSpeedUp;




@end

@implementation PlaygroundViewController

-(void)dealloc
{
    [self.myBallView stopBallViewMovement];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    self.startSpeedUp = NO;
    self.startDifficulty = 1.0;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupPlaygroundViewWithDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    self.playgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, self.view.frame.size.width - 40, self.view.frame.size.height - 120)];
    self.playgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.playgroundView];
    
    // левая граница игрового поля
    UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(self.playgroundView.bounds.origin.x, self.playgroundView.bounds.origin.y, 1.0f, self.playgroundView.bounds.size.height)];
    leftBorder.backgroundColor = [UIColor blackColor];
    [self.playgroundView addSubview:leftBorder];
    
    // права граница игрового поля
    UIView *rightBorder = [[UIView alloc] initWithFrame:CGRectMake(self.playgroundView.bounds.size.width, self.playgroundView.bounds.origin.y, 1.0f, self.playgroundView.bounds.size.height)];
    rightBorder.backgroundColor = [UIColor blackColor];
    [self.playgroundView addSubview:rightBorder];
    
    [self setupUpperPlayerWithDifficulty:difficulty];
    [self setupLowerPlayer];
    [self setupGameCountDownLabel];
}

-(void)setupUpperPlayerWithDifficulty:(CGFloat)difficulty
{
    self.highPlayer = [[UpperGamerView alloc] initWithFrame:CGRectMake(self.playgroundView.bounds.origin.x + (self.playgroundView.bounds.size.width/2) - 40.0f, self.playgroundView.bounds.origin.y + 1.0f , 80.0f, 5.0f)];
    
    [self.highPlayer setDifficulty:difficulty];
    [self.playgroundView addSubview:self.highPlayer];
}

-(void)setupLowerPlayer
{
    self.lowPlayer = [[LowerGamerView alloc] initWithFrame:CGRectMake(self.playgroundView.bounds.origin.x + (self.playgroundView.bounds.size.width/2) - 40.0f, self.playgroundView.bounds.origin.y + self.playgroundView.bounds.size.height - 6.0f, 80.0f, 5.0f)];
    [self.playgroundView addSubview:self.lowPlayer];
}

-(void)setupGameCountDownLabel
{
    self.myCountLabel = [[GameCountDownLabel alloc] initWithFrame:CGRectMake(self.playgroundView.center.x - 40.0f, (self.playgroundView.frame.size.height/2) - 40.0f, 40, 40)];
    self.myCountLabel.delegate = self;
    [self.playgroundView addSubview:self.myCountLabel];
    [self.myCountLabel startCountdown];
}

-(void)setupNewBallViewWithDifficulty:(CGFloat)difficulty ballSpeedUp:(BOOL)ballSpeedUp
{
    self.myBallView = [[BallView alloc] initWithFrame:CGRectMake(self.playgroundView.center.x - 20.0f, (self.playgroundView.frame.size.height/2) - 20.0f, 20, 20)];
    [self.myBallView setDifficulty:difficulty ballSpeedUp:ballSpeedUp];
    [self.playgroundView addSubview:self.myBallView];
    self.highPlayer.delegate = self.myBallView;
    self.lowPlayer.delegate = self.myBallView;
    self.myBallView.topDelegate = self.highPlayer;
    self.myBallView.bottomDelegate = self.lowPlayer;
    self.myBallView.pgDelegate = self;
    [self.myBallView startBallViewMovement];
}

-(void)prepareScoreLabel
{
    self.scoreUp = 0;
    self.scoreDown = 0;
    _scoreLabel = [UILabel new];
    _scoreLabel.text = [NSString stringWithFormat:@"Player  %ld | %ld  Computer", self.scoreDown, self.scoreUp];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_scoreLabel];
    NSLayoutConstraint *labelLeft = [_scoreLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0f];
    NSLayoutConstraint *labelRight = [_scoreLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0f];
    NSLayoutConstraint *labelUp = [_scoreLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30.0f];
    [NSLayoutConstraint activateConstraints:@[ labelLeft, labelRight, labelUp]];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint  point = [touch locationInView:self.view];
    if ((CGRectContainsPoint(self.playgroundView.frame, point)) && (self.myBallView.isMoving))
        [self.lowPlayer makeGamerMoveToPoint:point.x];
}

-(void)paintVictory
{
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
    [self.scoreLabel removeFromSuperview];
    [self.view addSubview:self.winnerLabel];
}

-(void)clearModels
{
    [self.myBallView removeFromSuperview];
    [self.highPlayer removeFromSuperview];
    [self.lowPlayer removeFromSuperview];
    [self.playgroundView removeFromSuperview];
    self.playgroundView = nil;
    self.myBallView = nil;
}



#pragma mark - PrefDelegate
-(void)startGameWith:(CGFloat)difficulty speedUp:(BOOL)speedUp
{
    if (self.winnerLabel != nil)
    {
        [self.winnerLabel removeFromSuperview];
        self.winnerLabel = nil;
    }
    
    if (self.myBallView != nil)
    {
        [self clearModels];
        [self.scoreLabel removeFromSuperview];
        self.scoreLabel = nil;
    }
    
    self.tabBarController.selectedViewController = self;
    self.startDifficulty = difficulty;
    self.startSpeedUp = speedUp;
    [self prepareScoreLabel];
    [self setupPlaygroundViewWithDifficulty:difficulty ballSpeedUp:speedUp];
}


#pragma mark - UITabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ((viewController != self) && (self.myBallView != nil))
    {
        [self.myBallView stopBallViewMovement];
        return;
    }
    
    if (self.playgroundView != nil)
    {
        [self setupGameCountDownLabel];
        return;
    }
}

#pragma mark - CountDownDelegate
-(void)refreshCountdownData
{
    [self.myCountLabel setNeedsDisplay];
}

-(void)continueGame
{
    [self.myCountLabel removeFromSuperview];
    if (self.myBallView != nil)
    {
        [self.myBallView startBallViewMovement];
        return;
    }
    [self setupNewBallViewWithDifficulty:self.startDifficulty ballSpeedUp:self.startSpeedUp];
}

#pragma mark - PlaygroundDelegate
-(void)gotRoundWinnerName:(NSString *) playerPos
{
    // останавливаем мяч, раунд окончен
    [self.myBallView stopBallViewMovement];
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
    
    _scoreLabel.text = [NSString stringWithFormat:@"Player  %ld | %ld  Computer", self.scoreDown, self.scoreUp];
    sleep(1);
    [self clearModels];
    if ((self.scoreUp >= self.scoreDown ? self.scoreUp : self.scoreDown) == scoreToWin)
    {
        [self paintVictory];
        return;
    }
    [self setupPlaygroundViewWithDifficulty:self.startDifficulty ballSpeedUp:self.startSpeedUp];
}

@end

