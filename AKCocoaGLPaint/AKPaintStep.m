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
        
        self.start = NSPointFromString(data[0]);
		self.end = NSPointFromString(data[1]);
        self.color = [NSColor colorWithCalibratedRed:[data[2] floatValue]
                                               green:[data[3] floatValue]
                                                blue:[data[4] floatValue]
                                               alpha:[data[5] floatValue]];
        self.pointSize = [data[6] floatValue];
        self.hardness = [data[7] floatValue];
        self.eraser = [data[8] boolValue];
        self.alpha = [data[9] floatValue];
        self.brushPixelStep = [data[10] floatValue];
    }
    return self;
}

- (NSArray*) data {
    
    CGFloat red, green, blue, alpha;
    [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[NSStringFromPoint(self.start),
            NSStringFromPoint(self.end),
            [NSNumber numberWithFloat:red],
            [NSNumber numberWithFloat:green],
            [NSNumber numberWithFloat:blue],
            [NSNumber numberWithFloat:alpha],
            @(self.pointSize),
            @(self.hardness),
            @(self.eraser),
            @(self.alpha),
            @(self.brushPixelStep)];
}


@end
