#import "NUILayout.h"

@class NUILoader;

@interface NUILayout (NUILoading)

- (BOOL)loadNUILayoutItemsFromRValue:(NSArray *)array loader:(NUILoader *)loader;

@end
