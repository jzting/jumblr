//
//  Tile.h
//  jumblr
//
//  Created by Jason Ting on 12/2/12.
//  Copyright (c) 2012 Jason Ting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TileDelegate;

@interface Tile : UIView

@property (nonatomic) NSString *letter;
@property(nonatomic, assign, readwrite) id <TileDelegate> delegate;

- (id)initWithFrame:(CGRect)frame letter:(NSString *)letter;

@end

@protocol TileDelegate <NSObject>

- (void)dragView:(UIView *)view toPoint:(CGPoint)point shouldSnap:(BOOL)snap;

@end