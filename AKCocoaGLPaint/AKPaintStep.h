//
//  AKPaintStep.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKPaintStep : NSObject

@property (retain) NSColor* color;
@property (assign) CGPoint start;
@property (assign) CGPoint end;
@property (assign) BOOL eraser;
@property (assign) float pointSize;
@property (assign) float hardness;
@property (assign) float alpha;
@property (assign) float brushPixelStep;

@property (readonly) NSArray* data;

- (id)initWithColor:(NSColor*)aColor start:(CGPoint)aStart end:(CGPoint)anEnd pointSize:(float) pointSize hardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha brushPixelStep:(float) step;
- (id)initWithData:(NSArray*)data;

@end
