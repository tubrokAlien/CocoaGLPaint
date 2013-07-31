//
//  NSImage+AKAdditions.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "NSImage+AKAdditions.h"

@implementation NSImage (AKAdditions)

- (CGImageRef)CGImage {
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[self TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    
    return maskRef;
}
- (NSImage *)imageWithAlpha:(float)alpha {
    
    NSImage *dragImage = [[[NSImage alloc] initWithSize:[self size]] autorelease];
    
    [dragImage lockFocus];
    [self compositeToPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:alpha];
    [dragImage unlockFocus];
    
    return dragImage;
}

@end
