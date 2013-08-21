//
//  AKAppDelegate.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AKCocoaGLPaint.h"

@interface AKAppDelegate : NSObject <NSApplicationDelegate> {

    AKPaintControl *_paintControl;
    AKPaintView *_paintView;
    NSWindow *_window;
}

@property (assign) IBOutlet AKPaintControl *paintControl;
@property (assign) IBOutlet AKPaintView *paintView;
@property (assign) IBOutlet NSWindow *window;

- (IBAction)sizeChanged:(NSSlider *)sender;
- (IBAction)opacityChanged:(NSSlider *)sender;
- (IBAction)softnessChanged:(NSSlider *)sender;
- (IBAction)colorChanged:(NSColorWell *)sender;

- (IBAction)brushEraserChanged:(NSSegmentedControl *)sender;

- (IBAction)undoPressed:(id)sender;
- (IBAction)redoPressed:(id)sender;
- (IBAction)savePressed:(id)sender;

@end
