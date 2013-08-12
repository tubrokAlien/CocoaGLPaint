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
	return [self CGImageForProposedRect:nil context:nil hints:nil];
}
- (NSImage *)imageWithAlpha:(float)alpha {
    
    NSImage *dragImage = [[NSImage alloc] initWithSize:[self size]];
    
    [dragImage lockFocus];
	[self drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:alpha];
    [dragImage unlockFocus];
    
    return dragImage;
}

- (void)writeToFile:(NSURL *)fileURL
{
    NSBitmapImageRep *bitmapRep = nil;
    
    for (NSImageRep *imageRep in [self representations])
    {
        if ([imageRep isKindOfClass:[NSBitmapImageRep class]])
        {
            bitmapRep = (NSBitmapImageRep *)imageRep;
            break; // stop on first bitmap rep we find
        }
    }
    
    if (!bitmapRep)
    {
        bitmapRep = [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];
    }
    
    NSData *imageData = [bitmapRep representationUsingType:[self fileTypeForFile:[fileURL lastPathComponent]] properties:nil];
    [imageData writeToURL:fileURL atomically:NO];
}

- (NSBitmapImageFileType)fileTypeForFile:(NSString *)file
{
    NSString *extension = [[file pathExtension] lowercaseString];
    
    if ([extension isEqualToString:@"png"])
    {
        return NSPNGFileType;
    }
    else if ([extension isEqualToString:@"gif"])
    {
        return NSGIFFileType;
    }
    else if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"jpeg"])
    {
        return NSJPEGFileType;
    }
    else
    {
        return NSTIFFFileType;
    }
}

@end
