#import "NUILayout/NUILayout.h"

@class NUILoader;

@interface NUILayout (NUILoading)

- (BOOL)loadNUISubviewsFromRValue:(NSArray *)array loader:(NUILoader *)loader;

@end
