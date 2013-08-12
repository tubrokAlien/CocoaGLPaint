//
//  AKPaintControl.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKPaintView;

@interface AKPaintControl : NSObject

@property (nonatomic, assign) float lineWidth;
@property (nonatomic, strong) NSColor * color;
@property (nonatomic, assign) float alpha;
@property (nonatomic, assign) float hardness;
@property (nonatomic, assign) BOOL eraser;
@property (nonatomic, strong) NSImage *brushImage;

@property (nonatomic, strong) IBOutlet AKPaintView *paintView;

- (id) initWithPaintView:(AKPaintView*)val;

- (void) loadDefaults;

+ (NSImage *) brushImageWithHardness:(float) hardness eraser:(BOOL) eraser alpha:(float) alpha;

@end
