//
//  UITextField+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NUILoading)

- (BOOL)setNUIAutocapitalizationType:(NSString *)value;
- (BOOL)setNUIAutocorrectionType:(NSString *)value;
- (BOOL)setNUIKeyboardType:(NSString *)value;

- (void)setLocalizedText:(NSString *)text;
- (void)setLocalizedPlaceholder:(NSString *)placeholder;

@end
