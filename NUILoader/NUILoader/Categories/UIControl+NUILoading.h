//
//  UIControl+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIObject;
@class NUILoader;

@interface UIControl (NUILoading)

- (BOOL)controlEvent:(UIControlEvents *)event fromNUIValue:(NSString *)value;
// Load subscribtion to event. Reuqired fields are event and selector. Use a suffix of one of the
// UIControlEvents values for event and a string for selector. Optional field is target. If it is
// not specified a root object is used.
- (BOOL)loadNUIActionFromRValue:(NUIObject *)value loader:(NUILoader *)loader;

@end
