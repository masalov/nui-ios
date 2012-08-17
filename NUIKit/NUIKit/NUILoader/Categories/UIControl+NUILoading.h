//
//  UIControl+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUILoader;
@class NUIError;

@interface UIControl (NUILoading)

+ (NSDictionary *)nuiConstantsForContentVerticalAlignment;
+ (NSDictionary *)nuiConstantsForContentHorizontalAlignment;

- (BOOL)controlEvent:(UIControlEvents *)event fromNUIValue:(NSString *)value;
// Load subscription to event. Required fields are event and selector. Use a suffix of one of the
// UIControlEvents values for event and a string for selector. Optional field is target. If it is
// not specified a root object is used.
- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
