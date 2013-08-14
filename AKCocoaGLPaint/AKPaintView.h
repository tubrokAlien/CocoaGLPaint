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
@private
    GLuint	brushTexture;
}

@property(nonatomic, strong) AKPaintSession *paintSession;
@property(nonatomic, strong) NSImage* brush;
@property(nonatomic, strong) NSColor* brushColor;
@property(nonatomic, assign) float pointSize;
@property(nonatomic, assign) float brushPixelStep;
@property(nonatomic, assign) float hardness;
@property(nonatomic, assign) BOOL eraser;
@property(nonatomic, assign) float pointAlpha;

@end
