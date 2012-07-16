#import "NUILayoutItem+NUILoading.h"

@implementation NUILayoutItem (NUILoading)

- (BOOL)setNUIVerticalAlignment:(NSString *)value
{
    if ([value isEqualToString:@"Center"]) {
        self.verticalAlignment = NUIVerticalAlignment_Center;
    } else if ([value isEqualToString:@"Top"]) {
        self.verticalAlignment = NUIVerticalAlignment_Top;
    } else if ([value isEqualToString:@"Bottom"]) {
        self.verticalAlignment = NUIVerticalAlignment_Bottom;
    } else if ([value isEqualToString:@"Stretch"]) {
        self.verticalAlignment = NUIVerticalAlignment_Stretch;
    } else {
        NSAssert(NO, @"Unknown vertical alignment");
        return NO;
    }
    return YES;
}

- (BOOL)setNUIHorizontalAlignment:(NSString *)value
{
    if ([value isEqualToString:@"Center"]) {
        self.horizontalAlignment = NUIHorizontalAlignment_Center;
    } else if ([value isEqualToString:@"Left"]) {
        self.horizontalAlignment = NUIHorizontalAlignment_Left;
    } else if ([value isEqualToString:@"Right"]) {
        self.horizontalAlignment = NUIHorizontalAlignment_Right;
    } else if ([value isEqualToString:@"Stretch"]) {
        self.horizontalAlignment = NUIHorizontalAlignment_Stretch;
    } else {
        NSAssert(NO, @"Unknown horizontal alignment");
        return NO;
    }
    return YES;
}

- (BOOL)setNUIVisibilty:(NSString *)value
{
    if ([value isEqualToString:@"Visible"]) {
        self.visibilty = NUIVisibility_Visible;
    } else if ([value isEqualToString:@"Hidden"]) {
        self.visibilty = NUIVisibility_Hidden;
    } else if ([value isEqualToString:@"Collapsed"]) {
        self.visibilty = NUIVisibility_Collapsed;
    } else {
        NSAssert(NO, @"Unknown visibility");
        return NO;
    }
    return YES;
}

@end
