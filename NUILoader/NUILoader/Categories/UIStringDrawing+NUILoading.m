//
//  UIStringDrawing+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIStringDrawing+NUILoading.h"

BOOL textAlignmentFromNUIValue(UITextAlignment *textAlignment, NSString *value)
{
    if ([value compare:@"Left" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *textAlignment = UITextAlignmentLeft;
        return YES;
    }
    if ([value compare:@"Center" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *textAlignment = UITextAlignmentCenter;
        return YES;
    }
    if ([value compare:@"Right" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *textAlignment = UITextAlignmentRight;
        return YES;
    }
    NSCAssert(NO, @"Unknown text alignment: %@", value);
    return NO;
}

BOOL lineBreakModeFromNUIValue(UILineBreakMode *lineBreakMode, NSString *value)
{
    if ([value compare:@"WordWrap" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeWordWrap;
        return YES;
    }
    if ([value compare:@"CharacterWrap" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeCharacterWrap;
        return YES;
    }
    if ([value compare:@"Clip" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeClip;
        return YES;
    }
    if ([value compare:@"HeadTruncation" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeHeadTruncation;
        return YES;
    }
    if ([value compare:@"TailTruncation" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeTailTruncation;
        return YES;
    }
    if ([value compare:@"MiddleTruncation" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *lineBreakMode = UILineBreakModeMiddleTruncation;
        return YES;
    }
    NSCAssert(NO, @"Unknown line break mode: %@", value);
    return NO;
}
