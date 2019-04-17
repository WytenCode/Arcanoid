//
//  PreferencesViewController.m
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "PreferencesViewController.h"
#import "PlaygroundViewController.h"

@interface PreferencesViewController ()
@property (nonatomic, strong) UILabel *prefsLabel;

@property (nonatomic, strong) UILabel *sliderLabel;
@property (nonatomic, retain) IBOutlet UISlider *difficultySlider;

@property (nonatomic, strong) UILabel *switchLabel;
@property (nonatomic, retain) IBOutlet UISwitch *speedBoostSwitch;

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self preparePrefsLabel];
    [self prepareDifficultySlider];
    [self prepareSpeedSwitch];
}


-(void)preparePrefsLabel
{
    self.prefsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 60.0f, 240.0f, 40.0f)];
    self.prefsLabel.text = @"Настройки";
    self.prefsLabel.textAlignment = NSTextAlignmentCenter;
    [self.prefsLabel setFont:[UIFont systemFontOfSize:40.0f]];
    [self.view addSubview:self.prefsLabel];
}

-(void)prepareDifficultySlider
{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 200.0f, 240.0f, 30.0f)];
    self.sliderLabel.text = @"Сложность игры";
    self.sliderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.sliderLabel];
    
    self.difficultySlider = [[UISlider alloc] initWithFrame: CGRectMake(self.view.center.x - 120.0f, 250.0f, 240.0f, 30.0f)];
    self.difficultySlider.minimumValue = 1.0;
    self.difficultySlider.maximumValue = 2.0;
    self.difficultySlider.continuous = YES;
    self.difficultySlider.value = 1.0;
    [self.difficultySlider addTarget:self action:@selector(difficultySliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.difficultySlider];
}

-(IBAction)difficultySliderAction:(id)sender
{
    
}

-(void)prepareSpeedSwitch
{
    self.switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 120.0f, 300.0f, 240.0f, 30.0f)];
    self.switchLabel.text = @"Увеличение скорости шарика";
    self.switchLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.switchLabel];
    
    self.speedBoostSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.center.x - 30.0f, 350.0f, 60.0f, 30.0f)];
    [self.speedBoostSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: self.speedBoostSwitch];
}

-(IBAction)switchAction:(id)sender
{
    
}

#pragma mark - InitDelegate

-(void)gameInitStarted
{
    // если еще не отрисованы настройки, отрисовываем, чтобы честно получить начальные значаения по слайдеру и свичу
    if (self.difficultySlider == nil)
        [self viewDidLoad];
    
    [self.delegate startGameWith:self.difficultySlider.value speedUp:self.speedBoostSwitch.on];
}

@end
