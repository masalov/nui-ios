//
//  NUIGridLayout+NUILoading.h
//  NUILayoutLoading
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUIGridLayout.h"

@class NUIStatement;
@class NUILoader;
@class NUIError;

/*! A category to support loading of properties of \b NUIGridLayout from NUI that can't be loaded
 *  automatically.
 */
@interface NUIGridLayout (NUILoading)

/*! Allows to load columns from a string containing values that can be used to initialize
 *  \b NUIGridLength (i.e., auto, 44, 56*)
 */
- (BOOL)loadNUIColumnsFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;
/*! Allows to load rows from a string containing values that can be used to initialize
 *  \b NUIGridLength (i.e., auto, 44, 56*)
 */
- (BOOL)loadNUIRowsFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
