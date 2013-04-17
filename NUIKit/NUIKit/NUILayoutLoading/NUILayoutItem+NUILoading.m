//
//  NUILayoutItem+NUILoading.m
//  NUILayoutLoading
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUILayoutItem+NUILoading.h"

@implementation NUILayoutItem (NUILoading)

+ (NSDictionary *)nuiConstantsForHorizontalAlignment
{
    static NSDictionary *horizontalAlignmentConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        horizontalAlignmentConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:NUIHorizontalAlignment_Left], @"Left",
            [NSNumber numberWithInt:NUIHorizontalAlignment_Stretch], @"Stretch",
            [NSNumber numberWithInt:NUIHorizontalAlignment_Center], @"Center",
            [NSNumber numberWithInt:NUIHorizontalAlignment_Right], @"Right",
            nil];
    });
    return horizontalAlignmentConstants;
}

+ (NSDictionary *)nuiConstantsForVerticalAlignment
{
    static NSDictionary *verticalAlignmentConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        verticalAlignmentConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:NUIVerticalAlignment_Top], @"Top",
            [NSNumber numberWithInt:NUIVerticalAlignment_Stretch], @"Stretch",
            [NSNumber numberWithInt:NUIVerticalAlignment_Center], @"Center",
            [NSNumber numberWithInt:NUIVerticalAlignment_Bottom], @"Bottom",
            nil];
    });
    return verticalAlignmentConstants;
}

+ (NSDictionary *)nuiConstantsForVisibility
{
    static NSDictionary *visibilityConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        visibilityConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:NUIVisibility_Hidden], @"Hidden",
            [NSNumber numberWithInt:NUIVisibility_Collapsed], @"Collapsed",
            [NSNumber numberWithInt:NUIVisibility_Visible], @"Visible",
            nil];
    });
    return visibilityConstants;
}

@end
