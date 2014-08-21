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
#pragma mark Properties

@synthesize lineWidth = _lineWidth;
@synthesize color = _color;
@synthesize alpha = _alpha;
@synthesize hardness = _hardness;
@synthesize eraser = _eraser;
@synthesize brushImage = _brushImage;

@synthesize paintView = _paintView;


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
    
    [super dealloc];
}



#pragma mark - 
#pragma mark Setters

- (void)setEraser:(BOOL)eraser {
    
    _eraser = eraser;
    
    self.paintView.eraser = _eraser;
}

- (void)setAlpha:(float)alpha {
    
    _alpha = alpha;
    
    self.paintView.pointAlpha = _alpha;
    self.paintView.brush = self.brushImage;
}

- (void)setColor:(NSColor *)color {
    
    [_color release];
    _color = [color retain] ;
    
    self.paintView.brushColor = _color;
}

- (void)setHardness:(float)hardness {

    _hardness = hardness;
    
    self.paintView.hardness = _hardness;
    self.paintView.brush = self.brushImage;
}

- (void)setLineWidth:(float)lineWidth {

    _lineWidth = lineWidth;
    
    float pointSize = _lineWidth * (1.02 + 0.6 * (1 - _hardness));
    self.paintView.pointSize = pointSize;
    self.paintView.brushPixelStep = pointSize * 0.1;
    
    self.paintView.brush = self.brushImage;
}
- (NSImage *)brushImage {
    
    return [AKPaintControl brushImageWithHardness:_hardness eraser:_eraser alpha:_alpha];
}

+ (NSImage *) brushImageWithHardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Brushes" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    NSString *brushkImgName = [NSString stringWithFormat:@"Brush_hardness_%i", (int)hardness*100];
    NSImage *brush = [[NSImage alloc] initWithData:[NSData dataWithContentsOfFile:[bundle pathForResource:brushkImgName ofType:@"png"]]];
    [brush autorelease];
    
    if(alpha != 1)
        brush = [brush imageWithAlpha:alpha];
    
    return brush;
}

@end
