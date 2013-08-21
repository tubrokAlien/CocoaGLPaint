//
//  AKPaintControl.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKPaintView;

@interface AKPaintControl : NSObject {
    
    float _lineWidth;
    NSColor *_color;
    float _alpha;
    float _hardness;
    BOOL _eraser;
    NSImage *_brushImage;
    
    AKPaintView *_paintView;
}

@property (nonatomic) float lineWidth;
@property (nonatomic, retain) NSColor * color;
@property (nonatomic) float alpha;
@property (nonatomic) float hardness;
@property (nonatomic) BOOL eraser;
@property (nonatomic, retain) NSImage *brushImage;

@property (nonatomic, retain) IBOutlet AKPaintView *paintView;

- (id) initWithPaintView:(AKPaintView*)val;

- (void) loadDefaults;

+ (NSImage *) brushImageWithHardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha;

@end
