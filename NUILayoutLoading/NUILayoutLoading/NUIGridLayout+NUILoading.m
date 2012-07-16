#import "NUIGridLayout+NUILoading.h"
#import "NUILayout/NUIGridLength.h"

@implementation NUIGridLayout (NUILoading)

- (BOOL)setNUIColumns:(NSString *)value
{
    NSArray *components = [value componentsSeparatedByString:@","];
    NSMutableArray *columns = [NSMutableArray arrayWithCapacity:components.count];
    for (NSString *str in components) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NUIGridLength *l = [[[NUIGridLength alloc] initWithString:str] autorelease];
        [columns addObject:l];
    }
    self.columns = columns;
    return YES;
}

- (BOOL)setNUIRows:(NSString *)value
{
    NSArray *components = [value componentsSeparatedByString:@","];
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:components.count];
    for (NSString *str in components) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NUIGridLength *l = [[[NUIGridLength alloc] initWithString:str] autorelease];
        [rows addObject:l];
    }
    self.rows = rows;
    return YES;
}

@end
