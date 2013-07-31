//
//  AKPaintView.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <OpenGL/OpenGL.h>
#import <Cocoa/Cocoa.h>

@class AKPaintSession;

@interface AKPaintView : NSOpenGLView {
    
    GLuint	brushTexture;
    
    NSRect lastBounds;
    
    NSPoint firstLocation;
    NSArray *sessionPrevDataArray;
}

@property(nonatomic, retain, readonly) AKPaintSession *paintSession;

@property(nonatomic, retain) NSImage* brush;
@property(nonatomic, retain) NSColor* brushColor;
@property(nonatomic, assign) float pointSize;
@property(nonatomic, assign) float brushPixelStep;
@property(nonatomic, assign) float hardness;
@property(nonatomic, assign) BOOL eraser;
@property(nonatomic, assign) float pointAlpha;

@end
