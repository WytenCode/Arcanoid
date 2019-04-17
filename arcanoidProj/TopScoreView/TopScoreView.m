//
//  TopScoreView.m
//  arcanoidProj
//
//  Created by Владимир on 13/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import "TopScoreView.h"

@interface  TopScoreViewController()

@property (nonatomic, strong) UILabel *headlabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end


@implementation TopScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self prepareHeadLabel];
    [self prepareScoreLabel];
    
    // Do any additional setup after loading the view.
}

-(void)prepareHeadLabel
{
    self.headlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 100)];
    self.headlabel.text = @"Лучший результат игрока";
    [self.view addSubview:self.headlabel];
}

-(void)prepareScoreLabel
{
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    self.scoreLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"scoreKey"];
    [self.view addSubview:self.scoreLabel];
}

-(void)updateTopScore;
{
    [self.scoreLabel removeFromSuperview];
    self.scoreLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"scoreKey"];
    [self.view addSubview:self.scoreLabel];
}


@end
