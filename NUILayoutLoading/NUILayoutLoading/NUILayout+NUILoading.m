#import "NUILayout+NUILoading.h"
#import "NUILayout/NUILayoutItem.h"
#import "NUILoader/NUILoader.h"
#import "NUILoader/NUIObject.h"

@implementation NUILayout (NUILoading)

- (BOOL)loadNUILayoutItemsFromRValue:(NSArray *)array loader:(NUILoader *)loader
{
    if (![array isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Layout items should be array.");
        return NO;
    }
    for (NUIObject *object in array) {
        if (![object isKindOfClass:[NUIObject class]]) {
            NSAssert(NO, @"Layout item should be dictionary.");
            return NO;
        }
        NUILayoutItem *item = [loader loadObjectOfClass:[NUILayoutItem class] fromNUIObject:object];
        if (item) {
            [self addSubview:item.view layoutItem:item];
        } else {
            NSAssert(NO, @"Failed to load layout item.");
            return NO;
        }
    }
    return YES;
}

@end
