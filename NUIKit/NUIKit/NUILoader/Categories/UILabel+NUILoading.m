//
//  UILabel+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UILabel+NUILoading.h"

@implementation UILabel (NUILoading)

- (void)setLocalizedText:(NSString *)text
{
    self.text = NSLocalizedString(text, nil);
}

+ (NSDictionary *)nuiConstantsForTextAlignment
{
    static NSDictionary *textAlignmentConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textAlignmentConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:UITextAlignmentLeft], @"Left",
            [NSNumber numberWithInt:UITextAlignmentCenter], @"Center",
            [NSNumber numberWithInt:UITextAlignmentRight], @"Right",
            nil];
    });
    return textAlignmentConstants;
}

+ (NSDictionary *)nuiConstantsForLineBreakMode
{
    static NSDictionary *lineBreakModeConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineBreakModeConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:UILineBreakModeWordWrap], @"WordWrap",
            [NSNumber numberWithInt:UILineBreakModeCharacterWrap], @"CharacterWrap",
            [NSNumber numberWithInt:UILineBreakModeClip], @"Clip",
            [NSNumber numberWithInt:UILineBreakModeHeadTruncation], @"HeadTruncation",
            [NSNumber numberWithInt:UILineBreakModeTailTruncation], @"TailTruncation",
            [NSNumber numberWithInt:UILineBreakModeMiddleTruncation], @"MiddleTruncation",
            nil];
    });

    return lineBreakModeConstants;
}

+ (NSDictionary *)nuiConstantsForBaselineAdjustment
{
    static NSDictionary *baselineAdjustmentConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baselineAdjustmentConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:UIBaselineAdjustmentNone], @"None",
            [NSNumber numberWithInt:UIBaselineAdjustmentAlignBaselines], @"AlignBaselines",
            [NSNumber numberWithInt:UIBaselineAdjustmentAlignCenters], @"AlignCenters",
            nil];
    });
    return baselineAdjustmentConstants;
}

@end
