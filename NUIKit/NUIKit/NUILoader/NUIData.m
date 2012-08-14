//
//  NUIError.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/10/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import "NUIData.h"

@implementation NUIData

@synthesize fileName = fileName_;
@synthesize data = data_;

- (void)dealloc
{
    [fileName_ release];
    [data_ release];

    [super dealloc];
}

- (NUIPositionInLine)positionInLineFromPosition:(int)position
{
    NUIPositionInLine result = {0, position};
    NSRange range = [data_ rangeOfString:@"\n" options:NSBackwardsSearch range:NSMakeRange(0,
        position)];
    if (range.length) {
        result.position = position - range.location - range.length;
        while (YES) {
            ++result.line;
            range = [data_ rangeOfString:@"\n" options:NSBackwardsSearch range:NSMakeRange(0,
                range.location)];
            if (!range.length) {
                break;
            }
        }
    }
    return result;
}

@end