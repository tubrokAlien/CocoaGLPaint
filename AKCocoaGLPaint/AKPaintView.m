//
//  AKPaintView.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKPaintView.h"
#import "AKPaintSession.h"
#import "AKPaintStep.h"
#import "AKPaintControl.h"
#include <GLUT/glut.h>

#import "NSImage+AKAdditions.h"

@implementation AKPaintView

#pragma mark -
#pragma mark Parend redeclarations

- (BOOL)isFlipped {
    
    //this make easy use for iOS developers
    return YES;
}

+ (NSOpenGLPixelFormat *)defaultPixelFormat
{
    static NSOpenGLPixelFormat *pf;
	
    if (pf == nil)
    {
		/*
         Making sure the context's pixel format doesn't have a recovery renderer is important - otherwise CoreImage may not be able to create deeper context's that share textures with this one.
         */
		static const NSOpenGLPixelFormatAttribute attr[] = {
			NSOpenGLPFAAccelerated,
			NSOpenGLPFANoRecovery,
			NSOpenGLPFAColorSize, 32,
			NSOpenGLPFAAllowOfflineRenderers,  /* Allow use of offline renderers */
			0
		};
		
		pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:(void *)&attr];
    }
	
    return pf;
}

- (void)prepareOpenGL
{
    self.paintSession = [[AKPaintSession alloc] init];
    
    GLint parm = 1;
    GLint val = 0;
	
    /* Enable beam-synced updates. */
	//make clear bg
    [[self openGLContext] setValues:&parm forParameter:NSOpenGLCPSwapInterval];
    [[self openGLContext] setValues:&val forParameter:NSOpenGLCPSurfaceOpacity];
    
    /* Make sure that everything we don't need is disabled. Some of these
     * are enabled by default and can slow down rendering. */
	
    glDisable(GL_ALPHA_TEST);
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_SCISSOR_TEST);
    glDisable(GL_BLEND);
    glDisable(GL_DITHER);
    glDisable(GL_CULL_FACE);
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_VERTEX_ARRAY);
    
    glEnable(GL_BLEND);
    // Set a blending function appropriate for premultiplied alpha pixel data
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glDepthMask(GL_FALSE);
    glStencilMask(0);
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glHint(GL_TRANSFORM_HINT_APPLE, GL_FASTEST);
}

// Releases resources when they are not longer needed.
- (void) dealloc
{
	if (brushTexture)
	{
		glDeleteTextures(1, &brushTexture);
		brushTexture = 0;
	}
    
  
    self.brush = nil;
    self.brushColor = nil;
}

#pragma mark -
#pragma mark Main methods

- (void)updateMatrices
{
    NSRect bounds = [self bounds];
	
    if (!NSEqualRects(bounds, lastBounds)) {
        
		[[self openGLContext] update];
		
		/* Install an orthographic projection matrix (no perspective)
		 * with the origin in the bottom left and one unit equal to one
		 * device pixel. */
		
		glViewport(0, 0, bounds.size.width, bounds.size.height);
		
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(0, bounds.size.width, 0, bounds.size.height, -1, 1);
		
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		
		lastBounds = bounds;
    }
}
- (void) updatePaintCanvasBySessionDataArray:(NSArray *) dataArray {
    
    [self.undoManager registerUndoWithTarget:self selector:@selector(updatePaintCanvasBySessionDataArray:) object:sessionPrevDataArray];
    
    [self.paintSession setDataArray:dataArray];
    
    sessionPrevDataArray = dataArray;
    
    [self setNeedsDisplay:YES];
}

- (AKPaintStep*) paintStepFromPoint:(CGPoint)start toPoint:(CGPoint)end {
    
    AKPaintStep* step = [[AKPaintStep alloc] initWithColor:self.brushColor start:start end:end pointSize:self.pointSize hardness:self.hardness eraser:self.eraser alpha:self.pointAlpha brushPixelStep:self.brushPixelStep];
    
    return step;
}


#pragma mark -
#pragma mark Mouse methods

- (void)mouseDown:(NSEvent *)theEvent {
    
    firstLocation = [self convertPoint:theEvent.locationInWindow fromView:nil];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    
    NSPoint loc = [self convertPoint:theEvent.locationInWindow fromView:nil];
    
    AKPaintStep *step = [self paintStepFromPoint:firstLocation toPoint:loc];
    [self.paintSession addStep:step];
    
    firstLocation = loc;
    
    float sz = self.pointSize * 100;
    
    [self setNeedsDisplayInRect:NSMakeRect(loc.x - sz/2, loc.y - sz/2, sz, sz)];
}
- (void)mouseUp:(NSEvent *)theEvent {
    
    [self updatePaintCanvasBySessionDataArray:self.paintSession.dataArray];
}


#pragma mark - 
#pragma mark Bind Methods

- (void) bindBrush {
    
    if (brushTexture)
	{
		glDeleteTextures(1, &brushTexture);
		brushTexture = 0;
	}
    
    [[self openGLContext] makeCurrentContext];
    
    CGImageRef brushImage = self.brush.CGImage;
    
    // Get the width and height of the image
    size_t width = CGImageGetWidth(brushImage);
    size_t height = CGImageGetHeight(brushImage);
    
    // Allocate  memory needed for the bitmap context
    GLubyte *brushData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte));
    // Use  the bitmatp creation function provided by the Core Graphics framework.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
	// suppress the warning about the kCGImageAlphaPremultipliedFirst parameter to CGBitmapContextCreate(); the documentation says it's safe
    CGContextRef brushContext = CGBitmapContextCreate(brushData, width, height, 8, width * 4, CGImageGetColorSpace(brushImage), kCGImageAlphaPremultipliedFirst);
#pragma clang diagnostic pop

    // After you create the context, you can draw the  image to the context.
    CGContextDrawImage(brushContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), brushImage);
    // You don't need the context at this point, so you need to release it to avoid memory leaks.
    CGContextRelease(brushContext);
    // Use OpenGL ES to generate a name for the texture.
    glGenTextures(1, &brushTexture);
    // Bind the texture name.
    glBindTexture(GL_TEXTURE_2D, brushTexture);
    // Set the texture parameters to use a minifying filter and a linear filer (weighted average)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    // Specify a 2D texture image, providing the a pointer to the image data in memory
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, brushData);
    // Release  the image data; it's no longer needed
    free(brushData);
    
    glEnable(GL_POINT_SPRITE);
    glTexEnvf(GL_POINT_SPRITE, GL_COORD_REPLACE, GL_TRUE);
    [self bindPointSize];
}
- (void) bindPointSize {
    
    glPointSize(self.pointSize);
}
- (void) bindBrushColor {
    
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    CGFloat red, green, blue, alpha;
    [self.brushColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    glColor4f(red, green, blue, alpha);
}
- (void) bindEraser {
    
    //blendFunc check
    //result = src * val1 + dst * val2;
    //result = (white) * (GL_ZERO) + (red) * (GL_ONE_MINUS_SRC_ALPHA) = (1, 1, 1, 1) * (0) + (1, 0, 0, 1) * (1-1) = 0;
    //result = (clear) * (GL_ZERO) + (red) * (GL_ONE_MINUS_SRC_ALPHA) = (0, 0, 0, 0) * (0) + (1, 0, 0, 1) * (1-0) = dst;
    
    glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);
    glColor4f(0, 0, 0, 1.0);
}


#pragma mark -
#pragma mark Render methods

- (void) renderLineFromPoint:(CGPoint)start toPoint:(CGPoint)end
{
    // Convert touch point from UIView referential to OpenGL one (upside-down flip)
    CGRect bounds = [self bounds];
    start.y = bounds.size.height - start.y;
    end.y = bounds.size.height - end.y;
    
	static GLfloat*		vertexBuffer = NULL;
	static NSUInteger	vertexMax = 64;
	NSUInteger			vertexCount = 0,
    count,
    i;
    
	// Convert locations from Points to Pixels
	CGFloat scale = 1; //self.contentScaleFactor;
	start.x *= scale;
	start.y *= scale;
	end.x *= scale;
	end.y *= scale;
    
	// Allocate vertex array buffer
	if(vertexBuffer == NULL)
		vertexBuffer = malloc(vertexMax * 2 * sizeof(GLfloat));
	
	// Add points to the buffer so there are drawing points every X pixels
	count = MAX(ceilf(sqrtf((end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y)) / self.brushPixelStep), 1);
	for(i = 0; i < count; ++i) {
		if(vertexCount == vertexMax) {
			vertexMax = 2 * vertexMax;
			vertexBuffer = realloc(vertexBuffer, vertexMax * 2 * sizeof(GLfloat));
		}
		
		vertexBuffer[2 * vertexCount + 0] = start.x + (end.x - start.x) * ((GLfloat)i / (GLfloat)count);
		vertexBuffer[2 * vertexCount + 1] = start.y + (end.y - start.y) * ((GLfloat)i / (GLfloat)count);
		vertexCount += 1;
	}
    
	// Render the vertex array
	glVertexPointer(2, GL_FLOAT, 0, vertexBuffer);
    glDrawArrays(GL_POINTS, 0, (GLsizei)vertexCount);
}

- (void)drawRect:(NSRect)rect
{
	[self updateMatrices];
    
    glClearColor(0, 0, 0, 0);
	glClear(GL_COLOR_BUFFER_BIT);
    
    BOOL mustBindBrush = YES;
    
    for(AKPaintStep *step in self.paintSession.steps) {
        
        //copy brush params if needed
        if(self.hardness != step.hardness || self.pointAlpha != step.alpha) {
            self.brush = [AKPaintControl brushImageWithHardness:step.hardness eraser:step.eraser alpha:step.alpha];
                          
            self.hardness = step.hardness;
            self.pointAlpha = step.alpha;
            
            mustBindBrush = YES;
        }
        
        //copy params
        if(![self.brushColor isEqual:step.color])
            self.brushColor = step.color;
        if(self.eraser != step.eraser)
            self.eraser = step.eraser;
        if(self.pointSize != step.pointSize)
            self.pointSize = step.pointSize;
        if(self.brushPixelStep != step.brushPixelStep)
            self.brushPixelStep = step.brushPixelStep;
        
        if(step.eraser)
            [self bindEraser];
        else
            [self bindBrushColor];
        
        [self bindPointSize];
        
        //make sure that we don't load image too many times
        if(mustBindBrush) {
            
            mustBindBrush = NO;
            [self bindBrush];
        }
        
        [self renderLineFromPoint:step.start toPoint:step.end];
    }
    
    glFinish();
}
@end
