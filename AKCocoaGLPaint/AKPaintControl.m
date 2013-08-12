//
//  AKPaintControl.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKPaintControl.h"
#import "AKPaintView.h"

#import "NSImage+AKAdditions.h"

@implementation AKPaintControl

#pragma mark -
#pragma mark Create/destroy methods

- (void) loadDefaults {
    
    //make some default values
    self.eraser = NO;
    self.color = [NSColor redColor];
    self.alpha = .5;
    self.hardness = .5;
    self.lineWidth = 50;
}

- (void)awakeFromNib {

    [self loadDefaults];
}

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        [self loadDefaults];
    }
    
    return self;
}
- (id)initWithPaintView:(AKPaintView *)val {
    
    self = [super init];
    
    if(self) {
        
        self.paintView = val;
        
        [self loadDefaults];
    }
    
    return self;
}
- (void)dealloc {
    
    self.color = nil;
    self.brushImage = nil;
    
    self.paintView = nil;
    
}



#pragma mark - 
#pragma mark Setters

- (void)setEraser:(BOOL)value {
   
    _eraser = value;
    
    self.paintView.eraser = value;
}

- (void)setAlpha:(float)value {
    
    _alpha = value;
    
    self.paintView.pointAlpha = value;
    self.paintView.brush = self.brushImage;
}

- (void)setColor:(NSColor *)value {
    
    _color = value ;
    
    self.paintView.brushColor = value;
}

- (void)setHardness:(float)value {

    _hardness = value;
    
    self.paintView.hardness = value;
    self.paintView.brush = self.brushImage;
}

- (void)setLineWidth:(float)value {

    _lineWidth = value;
    
    float pointSize = value * (1.02 + 0.6 * (1 - self.hardness));
    self.paintView.pointSize = pointSize;
    self.paintView.brushPixelStep = pointSize * 0.1;
    
    self.paintView.brush = self.brushImage;
}
- (NSImage *)brushImage {
    
    return [AKPaintControl brushImageWithHardness:self.hardness eraser:self.eraser alpha:self.alpha];
}

+ (NSImage *) brushImageWithHardness:(float) hardnessValue eraser:(BOOL) eraserValue alpha:(float) alphaValue {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Brushes" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    NSString *brushkImgName = [NSString stringWithFormat:@"Brush_hardness_%i", (int)hardnessValue*100];
    NSImage *brush = [[NSImage alloc] initWithData:[NSData dataWithContentsOfFile:[bundle pathForResource:brushkImgName ofType:@"png"]]];
    
    if(alphaValue != 1)
        brush = [brush imageWithAlpha:alphaValue];
    
    return brush;
}

@end
