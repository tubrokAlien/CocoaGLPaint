//
//  NSOpenGLView+AKAdditions.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <OpenGL/glu.h>

@interface NSOpenGLView (AKAdditions)

- (NSImage *) snapshot;

@end
