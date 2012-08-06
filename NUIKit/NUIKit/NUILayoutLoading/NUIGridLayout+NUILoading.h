#import "NUIGridLayout.h"

@interface NUIGridLayout (NUILoading)

// the 'value' argument should be values that can be used to initialize NUIGridLengh (auto, 44, 56*)
// separated by commas
- (BOOL)setNUIColumns:(NSString *)value;
- (BOOL)setNUIRows:(NSString *)value;

@end
