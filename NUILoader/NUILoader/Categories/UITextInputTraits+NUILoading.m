//
//  UITextInputTraits+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UITextInputTraits+NUILoading.h"

BOOL autocapitalizationTypeFromNUIValue(UITextAutocapitalizationType *autocapitalizationType,
                                        NSString *value)
{
    if ([value compare:@"None" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocapitalizationType = UITextAutocapitalizationTypeNone;
        return YES;
    }
    if ([value compare:@"Words" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocapitalizationType = UITextAutocapitalizationTypeWords;
        return YES;
    }
    if ([value compare:@"Sentences" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocapitalizationType = UITextAutocapitalizationTypeSentences;
        return YES;
    }
    if ([value compare:@"AllCharacters" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        return YES;
    }

    NSCAssert(NO, @"Unknown autocapitalization type: %@", value);
    return NO;
}

BOOL autocorrectionTypeFromNUIValue(UITextAutocorrectionType *autocorrectionType, NSString *value)
{
    if ([value compare:@"Default" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocorrectionType = UITextAutocorrectionTypeDefault;
        return YES;
    }
    if ([value compare:@"No" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocorrectionType = UITextAutocorrectionTypeNo;
        return YES;
    }
    if ([value compare:@"Yes" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *autocorrectionType = UITextAutocorrectionTypeYes;
        return YES;
    }

    NSCAssert(NO, @"Unknown autocorrection type: %@", value);
    return NO;
}

BOOL keyboardTypeFromNUIValue(UIKeyboardType *keyboardType, NSString *value)
{
    if ([value compare:@"Default" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeDefault;
        return YES;
    }
    if ([value compare:@"ASCIICapable" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeASCIICapable;
        return YES;
    }
    if ([value compare:@"NumbersAndPunctuation" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        return YES;
    }
    if ([value compare:@"URL" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeURL;
        return YES;
    }
    if ([value compare:@"NumberPad" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeNumberPad;
        return YES;
    }
    if ([value compare:@"PhonePad" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypePhonePad;
        return YES;
    }
    if ([value compare:@"NamePhonePad" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeNamePhonePad;
        return YES;
    }
    if ([value compare:@"EmailAddress" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *keyboardType = UIKeyboardTypeEmailAddress;
        return YES;
    }

    NSCAssert(NO, @"Unknown keyboard type: %@", value);
    return NO;
}
