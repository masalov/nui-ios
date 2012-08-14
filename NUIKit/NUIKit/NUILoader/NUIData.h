//
//  NUIError.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/10/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct NUIPositionInLine {
    int line;
    int position;
} NUIPositionInLine;

@interface NUIData : NSObject

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *data;

- (NUIPositionInLine)positionInLineFromPosition:(int)position;

@end