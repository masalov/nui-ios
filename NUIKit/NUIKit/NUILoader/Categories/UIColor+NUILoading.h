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

/*! A category to support loading of \b UIColor objects from NUI. */
@interface UIColor (NUILoading)

/*! Allows to load \b UIColor from NUI. There are several ways to set color:
 *  * \b color - a string with HTML code of a color or a string of 8 symbols: HTML code + alpha.
 *  * \b red, \b green, \b blue, \b alpha - numeric values, alpha is optional.
 *  * \b patternImage - a string with a image name from resources that will be used to create a
 *    color with \b colorWithPatternImage: method.
 */
+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end