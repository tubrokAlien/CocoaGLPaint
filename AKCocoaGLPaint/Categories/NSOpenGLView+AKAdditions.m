//
//  NSOpenGLView+AKAdditions.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "NSOpenGLView+AKAdditions.h"
#include <OpenGL/glu.h>

@implementation NSOpenGLView (AKAdditions)

static void memxor(unsigned char *dst, unsigned char *src, unsigned int bytes)
{
    while (bytes--) *dst++ ^= *src++;
}

static void memswap(unsigned char *a, unsigned char *b, unsigned int bytes)
{
    memxor(a, b, bytes);
    memxor(b, a, bytes);
    memxor(a, b, bytes);
}

- (NSImage *) snapshot
{
	NSRect bounds;
	int height, width, row, bytesPerRow;
	NSBitmapImageRep *imageRep;
	unsigned char *bitmapData;
	NSImage *image;
	
	bounds = [self bounds];
	
	height = bounds.size.height;
	width = bounds.size.width;
	
	imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes: NULL
                                                       pixelsWide: width
                                                       pixelsHigh: height
                                                    bitsPerSample: 8
                                                  samplesPerPixel: 4
                                                         hasAlpha: YES
                                                         isPlanar: NO
                                                   colorSpaceName: NSCalibratedRGBColorSpace
                                                      bytesPerRow: 0				// indicates no empty bytes at row end
                                                     bitsPerPixel: 0];
    
	[[self openGLContext] makeCurrentContext];
    
	bitmapData = [imageRep bitmapData];
    
    //make xcode happy
	bytesPerRow = (int)[imageRep bytesPerRow];
	
	glPixelStorei(GL_PACK_ROW_LENGTH, 8*bytesPerRow/[imageRep bitsPerPixel]);
    
	glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, bitmapData);
    
	// Flip the bitmap vertically to account for OpenGL coordinate system difference
	// from NSImage coordinate system.
	
	for (row = 0; row < height/2; row++)
	{
		unsigned char *a, *b;
		
		a = bitmapData + row * bytesPerRow;
		b = bitmapData + (height - 1 - row) * bytesPerRow;
		
		memswap(a, b, bytesPerRow);
	}
    
	// Create the NSImage from the bitmap
    
	image = [[NSImage alloc] initWithSize: NSMakeSize(width, height)];
	[image addRepresentation: imageRep];
	
	// Previously we did not flip the bitmap, and instead did [image setFlipped:YES];
	// This does not work properly (i.e., the image remained inverted) when pasting
	// the image to AppleWorks or GraphicConvertor.
    
	return image;
}


@end
