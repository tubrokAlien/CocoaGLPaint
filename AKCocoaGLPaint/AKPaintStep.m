//
//  AKPaintStep.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKPaintStep.h"

@implementation AKPaintStep

- (id)initWithColor:(NSColor*)aColor start:(CGPoint)aStart end:(CGPoint)anEnd pointSize:(float) pointSize hardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha brushPixelStep:(float) step {
    if ((self = [super init])) {
        self.color = aColor;
        self.start = aStart;
        self.end = anEnd;
        self.pointSize = pointSize;
        self.hardness = hardness;
        self.eraser = eraser;
        self.alpha = alpha;
        self.brushPixelStep = step;
    }
    return self;
}

- (id)initWithData:(NSArray*)data {
    if ((self = [super init])) {
        
        self.start = NSPointFromString([data objectAtIndex:0]);
		self.end = NSPointFromString([data objectAtIndex:1]);
        self.color = [NSColor colorWithCalibratedRed:[[data objectAtIndex:2] floatValue]
                                               green:[[data objectAtIndex:3] floatValue]
                                                blue:[[data objectAtIndex:4] floatValue]
                                               alpha:[[data objectAtIndex:5] floatValue]];
        self.pointSize = [[data objectAtIndex:6] floatValue];
        self.hardness = [[data objectAtIndex:7] floatValue];
        self.eraser = [[data objectAtIndex:8] boolValue];
        self.alpha = [[data objectAtIndex:9] floatValue];
        self.brushPixelStep = [[data objectAtIndex:10] floatValue];
    }
    return self;
}

- (NSArray*) data {
    
    CGFloat red, green, blue, alpha;
    [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSArray arrayWithObjects:NSStringFromPoint(self.start),
            NSStringFromPoint(self.end),
            [NSNumber numberWithFloat:red],
            [NSNumber numberWithFloat:green],
            [NSNumber numberWithFloat:blue],
            [NSNumber numberWithFloat:alpha],
            [NSNumber numberWithFloat:self.pointSize],
            [NSNumber numberWithFloat:self.hardness],
            [NSNumber numberWithBool:self.eraser],
            [NSNumber numberWithFloat:self.alpha],
            [NSNumber numberWithFloat:self.brushPixelStep],
            nil];
}

- (void)dealloc {
    
    self.color = nil;
    
    [super dealloc];
}

@end
