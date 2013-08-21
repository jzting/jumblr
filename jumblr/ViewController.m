//
//  ViewController.m
//  jumblr
//
//  Created by Jason Ting on 12/2/12.
//  Copyright (c) 2012 Jason Ting. All rights reserved.
//

#import "ViewController.h"
#import "Tile.h"

#define SCREEN_PADDING 10
#define WORD_LENGTH 5
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.height
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.width
#define TILE_SIZE (SCREEN_WIDTH - (SCREEN_PADDING * 2)) / WORD_LENGTH


@interface ViewController ()
@property (nonatomic) UIDynamicAnimator *animator;
@end

@implementation ViewController {
    NSMutableArray *snapPositions;
}

- (void)viewDidLoad {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    snapPositions = [[NSMutableArray alloc] init];

    for (int i = 0; i < WORD_LENGTH; i++) {
        Tile *tile = [[Tile alloc] initWithFrame:CGRectMake(0, 0, TILE_SIZE, TILE_SIZE) letter:@"X"];
        tile.backgroundColor = [UIColor whiteColor];
        int xPosition = SCREEN_PADDING + (i * TILE_SIZE) + (TILE_SIZE / 2);
        [snapPositions addObject:@(xPosition)];
        tile.center = CGPointMake(xPosition, SCREEN_HEIGHT / 2);
        tile.delegate = self;
        [self.view addSubview:tile];
    }

    NSLog(@"snapPositions: %@", snapPositions);
}

- (int)findSnapPosition:(int)x {
    int diff = 10000;
    int candidate = 0;
    for (NSNumber *position in snapPositions) {
        int positionValue = [position intValue];
        if (abs(positionValue  - x) < diff) {
            diff = abs(positionValue - x);
            candidate = positionValue;
        }
    }
    return candidate;
}

#pragma mark - Tile delegate
- (void)dragView:(UIView *)view toPoint:(CGPoint)point shouldSnap:(BOOL)shouldSnap {

    // adjust point to appropriate snap position
    if (shouldSnap) {
        point.x = [self findSnapPosition:point.x];
        point.y = SCREEN_HEIGHT / 2;
    }

    UISnapBehavior* snapBehavior = [[UISnapBehavior alloc] initWithItem:view snapToPoint:point];
    snapBehavior.damping = 1;
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:snapBehavior];
}

@end
