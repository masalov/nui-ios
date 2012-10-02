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
