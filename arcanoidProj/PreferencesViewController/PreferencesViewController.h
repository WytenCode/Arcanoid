//
//  PreferencesViewController.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PreferencesViewController : UIViewController <InitDelegate>

@property (nonatomic, weak) id<PrefDelegate> delegate;

-(void)gameInitStarted;

@end
