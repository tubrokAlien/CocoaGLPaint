//
//  AKPaintSession.h
//  AKCocoaGLPaintSample
//
//  Created by Alen Korbut on 31.07.13.
//  Copyright (c) 2013 KorbCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKPaintStep;

@interface AKPaintSession : NSObject {
    NSMutableArray* _steps;
}

@property (readonly) NSArray* steps;

- (id)initWithDataArray:(NSArray *) array;
- (NSArray *) dataArray;
- (void) setDataArray:(NSArray *) array;

- (void)addStep:(AKPaintStep*)step;
- (void)clear;

@end
