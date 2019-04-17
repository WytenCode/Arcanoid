//
//  TopScoreView.h
//  arcanoidProj
//
//  Created by Владимир on 13/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScoreDelegate <NSObject>

-(void)updateTopScore;

@end

@interface TopScoreViewController : UIViewController <ScoreDelegate>

@end
