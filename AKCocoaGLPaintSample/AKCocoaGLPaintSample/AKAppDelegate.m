//
//  AKAppDelegate.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKAppDelegate.h"

@implementation AKAppDelegate

@synthesize paintControl = _paintControl;
@synthesize paintView = _paintView;
@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
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

- (IBAction)savePressed:(id)sender {
    
    NSImage *img = [self.paintView snapshot];
    
    NSString *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [dirPath stringByAppendingPathComponent:@"CocoaGLPaintSample.png"];
    [img writeToFile:[NSURL fileURLWithPath:path]];
    
    NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:@"File saved to %@", path] defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert beginSheetModalForWindow:self.window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    
    [[NSWorkspace sharedWorkspace] openURL: [NSURL fileURLWithPath:dirPath]];
}

@end
