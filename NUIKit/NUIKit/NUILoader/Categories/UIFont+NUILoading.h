//
//  UIFont+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUIError;
@class NUILoader;

/*! A category to support loading of \b UIFont objects from NUI. */
@interface UIFont (NUILoading)

/*! Allows to load \b UIFont from NUI. The following properties are can be used:
 *  * \b size - a font size.
 *  * \b name - a font name (optional, system font is used by default).
 *  * \b type - a system font type: \b bold, \b italic or \b normal (optional, \b normal by
 *    default).
 */
+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
