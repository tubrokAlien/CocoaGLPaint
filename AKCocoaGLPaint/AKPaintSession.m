//
//  AKPaintSession.m
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import "AKPaintSession.h"
#import "AKPaintStep.h"

@implementation AKPaintSession

@synthesize steps = _steps;

- (id) init {
    if ((self = [super init])) {
        _steps = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)dealloc {
    
    [_steps release];
    
    [super dealloc];
}

- (id)initWithDataArray:(NSArray *) array {
    if ((self = [super init])) {
        _steps = [[NSMutableArray alloc] init];
        [self setDataArray:array];
    }
    return self;
}

- (void) clear {
    [_steps removeAllObjects];
}

- (void) setDataArray:(NSArray *) array {
    
    [self clear];
    
    for (NSArray* stepData in array) {
        AKPaintStep* step = [[AKPaintStep alloc] initWithData:stepData];
        [_steps addObject:step];
    }
}

- (NSArray *) dataArray {
    
    NSMutableArray* data = [NSMutableArray arrayWithCapacity:self.steps.count];
    for (AKPaintStep* step in self.steps) {
        [data addObject:step.data];
    }
	
    return data;
}

- (void) addStep:(AKPaintStep*)step {
    [_steps addObject:step];
}

@end
