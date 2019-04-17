//
//  MainViewController.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "MainViewController.h"
#import "PreferencesViewController.h"


@interface MainViewController ()

@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *preferencesButton;
@property (nonatomic, strong) UIButton *resumeGameButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self prepareAppNameLabel];
    [self prepareStartButton];
    [self preparePreferencesButton];
    [self prepareResumeGameButton];
    
    
    // Do any additional setup after loading the view.
}

-(void)prepareAppNameLabel
{
    self.appNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 60.0f, 240.0f, 40.0f)];
    self.appNameLabel.text = @"ARCANOID";
    self.appNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.appNameLabel setFont:[UIFont systemFontOfSize:40.0f]];
    [self.view addSubview:self.appNameLabel];
}

-(void)prepareStartButton
{
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 250.0f, 240.0f, 30.0f)];
    self.startButton.backgroundColor = [UIColor whiteColor];
    [self.startButton setTitle:@"Начать игру" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.startButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.startButton.layer.borderWidth = 1.0f;
    [self.startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
}

-(void)prepareResumeGameButton
{
    self.resumeGameButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 300.0f, 240.0f, 30.0f)];
    self.resumeGameButton.backgroundColor = [UIColor whiteColor];
    [self.resumeGameButton setTitle:@"Продолжить игру" forState:UIControlStateNormal];
    [self.resumeGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.resumeGameButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.resumeGameButton.layer.borderWidth = 1.0f;
    [self.resumeGameButton addTarget:self action:@selector(resumeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resumeGameButton];
    [self disableResumeButton];
}

-(void)preparePreferencesButton
{
    self.preferencesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 350.0f, 240.0f, 30.0f)];
    self.preferencesButton.backgroundColor = [UIColor whiteColor];
    [self.preferencesButton setTitle:@"Настройки" forState:UIControlStateNormal];
    [self.preferencesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.preferencesButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.preferencesButton.layer.borderWidth = 1.0f;
    [self.preferencesButton addTarget:self action:@selector(preferencesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.preferencesButton];
}

-(void)disableResumeButton
{
    self.resumeGameButton.enabled = NO;
    self.resumeGameButton.layer.opacity = 0.5f;
}

-(void)enableResumeButton
{
    self.resumeGameButton.enabled = YES;
    self.resumeGameButton.layer.opacity = 1.0;
}

-(void)startButtonPressed
{
    [self.delegate gameInitStarted];
}

-(void)preferencesButtonPressed
{
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
}

-(void)resumeButtonPressed
{
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

#pragma mark - GameObserverDelegate
-(void)gameOn
{
    [self enableResumeButton];
}

-(void)gameOff
{
    [self disableResumeButton];
}

@end
