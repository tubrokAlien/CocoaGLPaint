//
//  AKPaintStep.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKPaintStep : NSObject

@property (nonatomic, strong) NSColor* color;
@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;
@property (nonatomic, assign) BOOL eraser;
@property (nonatomic, assign) float pointSize;
@property (nonatomic, assign) float hardness;
@property (nonatomic, assign) float alpha;
@property (nonatomic, assign) float brushPixelStep;
@property (nonatomic, assign) BOOL shouldDraw;

@property (weak, readonly) NSArray* data;

- (id)initWithColor:(NSColor*)aColor start:(CGPoint)aStart end:(CGPoint)anEnd pointSize:(float) pointSize hardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha brushPixelStep:(float) step;
- (id)initWithData:(NSArray*)data;

@end
