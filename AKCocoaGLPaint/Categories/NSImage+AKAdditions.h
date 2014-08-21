//
//  NSImage+AKAdditions.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (AKAdditions)

- (CGImageRef) CGImage;
- (void) useCGImageWithBlock:(void(^)(CGImageRef img))block;
- (NSImage *) imageWithAlpha:(float)alpha;

- (void)writeToFile:(NSURL *)fileURL;

@end
