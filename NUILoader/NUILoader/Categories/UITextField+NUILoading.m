//
//  UITextField+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UITextField+NUILoading.h"
#import "UITextInputTraits+NUILoading.h"

@implementation UITextField (NUILoading)

- (BOOL)setNUIAutocapitalizationType:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return NO;
    }
    UITextAutocapitalizationType autocapitalizationType = 0;
    if (!autocapitalizationTypeFromNUIValue(&autocapitalizationType, value)) {
        return NO;
    }
    self.autocapitalizationType = autocapitalizationType;
    return YES;
}

- (BOOL)setNUIAutocorrectionType:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return NO;
    }
    UITextAutocorrectionType autocorrectionType = 0;
    if (!autocorrectionTypeFromNUIValue(&autocorrectionType, value)) {
        return NO;
    }
    self.autocorrectionType = autocorrectionType;
    return YES;
}

- (BOOL)setNUIKeyboardType:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return NO;
    }
    UIKeyboardType keyboardType = 0;
    if (!keyboardTypeFromNUIValue(&keyboardType, value)) {
        return NO;
    }
    self.keyboardType = keyboardType;
    return YES;
}

- (void)setLocalizedText:(NSString *)text
{
    self.text = NSLocalizedString(text, nil);
}

- (void)setLocalizedPlaceholder:(NSString *)placeholder
{
    self.placeholder = NSLocalizedString(placeholder, nil);
}

@end