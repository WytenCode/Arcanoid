//
//  ViewController.h
//  arcanoidProj
//
//  Created by Владимир on 11/04/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InitDelegate <NSObject>

-(void)gameInitStarted;

@end

@protocol PrefDelegate <NSObject>

-(void)startGameWith:(CGFloat)difficulty speedUp:(BOOL)speedUp;

@end

@interface ViewController : UIViewController


@end


