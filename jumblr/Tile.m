//
//  Tile.m
//  jumblr
//
//  Created by Jason Ting on 12/2/12.
//  Copyright (c) 2012 Jason Ting. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (id)initWithFrame:(CGRect)frame letter:(NSString *)letter {
    if (self = [super initWithFrame:frame]) {
        _letter = letter;

        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = letter;
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:80];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate dragView:self toPoint:[[touches anyObject] locationInView:self.superview] shouldSnap:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate dragView:self toPoint:[[touches anyObject] locationInView:self.superview] shouldSnap:YES];
}



@end
