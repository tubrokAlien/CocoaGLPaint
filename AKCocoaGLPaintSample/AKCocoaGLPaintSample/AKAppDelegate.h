//
//  AKAppDelegate.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AKCocoaGLPaint.h"

@interface AKAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet AKPaintControl *paintControl;
@property (weak) IBOutlet AKPaintView *paintView;
@property (weak) IBOutlet NSWindow *window;

- (IBAction)sizeChanged:(NSSlider *)sender;
- (IBAction)opacityChanged:(NSSlider *)sender;
- (IBAction)softnessChanged:(NSSlider *)sender;
- (IBAction)colorChanged:(NSColorWell *)sender;

- (IBAction)brushEraserChanged:(NSSegmentedControl *)sender;

- (IBAction)undoPressed:(id)sender;
- (IBAction)redoPressed:(id)sender;
- (IBAction)savePressed:(id)sender;

@end
