//
//  UIColor+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 8/17/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUILoader;
@class NUIError;

@interface UIColor (NUILoading)

// Loads font from a NUI element. Should have color attribute or red, blue, green and alpha.
+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end