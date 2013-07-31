//
//  AKAppDelegate.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKAppDelegate.h"

@implementation AKAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)awakeFromNib {
    
}

- (IBAction)sizeChanged:(NSSlider *)sender {

    self.paintControl.lineWidth = sender.floatValue;
}

- (IBAction)opacityChanged:(NSSlider *)sender {
    
    self.paintControl.alpha = sender.floatValue;
}

- (IBAction)softnessChanged:(NSSlider *)sender {
    
    self.paintControl.hardness = sender.floatValue;
}

- (IBAction)colorChanged:(NSColorWell *)sender {
    
    self.paintControl.color = sender.color;
}

- (IBAction)brushEraserChanged:(NSSegmentedControl *)sender {
    
    self.paintControl.eraser = sender.selectedSegment == 1;
}

- (IBAction)undoPressed:(id)sender {
    
    [self.paintView.undoManager undo];
}

- (IBAction)redoPressed:(id)sender {
    
    [self.paintView.undoManager redo];
}

@end
