//
//  NUILayout+NUILoading.h
//  NUILayoutLoading
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUILayout.h"

@class NUIStatement;
@class NUILoader;
@class NUIError;

/*! A category to support loading of properties of \b NUILayout from NUI that can't be loaded
 *  automatically.
 */
@interface NUILayout (NUILoading)

/*! Allows to load layout items with subviews from an array. */
- (BOOL)loadNUILayoutItemsFromRValue:(NUIStatement *)array loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
