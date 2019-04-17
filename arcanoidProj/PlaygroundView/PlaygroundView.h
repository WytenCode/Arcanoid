//
//  PlaygroundView.h
//  arcanoidProj
//
//  Created by Владимир on 17/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolHolder.h"

@interface PlaygroundView : UIView <PlaygroundMoveDelegate, CountDownDelegate, PlaygroundDelegate>

@property (nonatomic, weak) id<PlaygroundDelegate> pgDelegate;

@end

