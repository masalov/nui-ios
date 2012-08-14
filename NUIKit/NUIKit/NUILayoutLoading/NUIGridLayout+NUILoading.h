#import "NUIGridLayout.h"

@class NUIStatement;
@class NUILoader;
@class NUIError;

@interface NUIGridLayout (NUILoading)

// the 'value' argument should be values that can be used to initialize NUIGridLength (auto, 44, 56*)
// separated by commas
- (BOOL)loadNUIColumnsFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;
- (BOOL)loadNUIRowsFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
