#import "NUILayout.h"

@class NUIStatement;
@class NUILoader;
@class NUIError;

@interface NUILayout (NUILoading)

- (BOOL)loadNUILayoutItemsFromRValue:(NUIStatement *)array loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
