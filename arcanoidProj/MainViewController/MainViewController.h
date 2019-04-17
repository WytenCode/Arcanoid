//
//  MainViewController.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolHolder.h"


@interface MainViewController : UIViewController <GameObserverProtocol>

@property (nonatomic, weak) id<InitDelegate> delegate;

@end
