//
//  PlaygroundViewController.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaygroundView.h"
#import "ProtocolHolder.h"

@interface PlaygroundViewController : UIViewController <PrefDelegate, PlaygroundDelegate>

@property (nonatomic, weak) id<GameObserverProtocol> gameObserverDelegate;
@property (nonatomic, weak) id<PlaygroundMoveDelegate> moveDelegate;

@end


