//
//  UILabel+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UILabel (NUILoading)

- (void)setLocalizedText:(NSString *)text;

- (BOOL)setNUITextAlignment:(NSString *)value;
- (BOOL)setNUILineBreakMode:(NSString *)value;

@end
