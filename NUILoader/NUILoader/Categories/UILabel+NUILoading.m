//
//  UILabel+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UILabel+NUILoading.h"
#import "UIStringDrawing+NUILoading.h"

@implementation UILabel (NUILoading)

- (void)setLocalizedText:(NSString *)text
{
    self.text = NSLocalizedString(text, nil);
}

- (BOOL)setNUITextAlignment:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return NO;
    }
    UITextAlignment textAlignment;
    if (!textAlignmentFromNUIValue(&textAlignment, value)) {
        return NO;
    }
    self.textAlignment = textAlignment;
    return YES;
}

- (BOOL)setNUILineBreakMode:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return NO;
    }
    UILineBreakMode lineBreakMode;
    if (!lineBreakModeFromNUIValue(&lineBreakMode, value)) {
        return NO;
    }
    self.lineBreakMode = lineBreakMode;
    return YES;
}

@end
