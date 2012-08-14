//
//  UIControl+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIControl+NUILoading.h"
#import "NUIStatement+Object.h"
#import "NUILoader.h"
#import "NUIError.h"

@implementation UIControl (NUILoading)

- (BOOL)controlEvent:(UIControlEvents *)event fromNUIValue:(NSString *)value
{
    if ([value compare:@"TouchDown" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDown;
        return YES;
    }
    if ([value compare:@"TouchDownRepeat" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDownRepeat;
        return YES;
    }
    if ([value compare:@"TouchDragInside" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDragInside;
        return YES;
    }
    if ([value compare:@"TouchDragOutside" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDragOutside;
        return YES;
    }
    if ([value compare:@"TouchDragEnter" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDragEnter;
        return YES;
    }
    if ([value compare:@"TouchDragExit" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchDragExit;
        return YES;
    }
    if ([value compare:@"TouchUpInside" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchUpInside;
        return YES;
    }
    if ([value compare:@"TouchUpOutside" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchUpOutside;
        return YES;
    }
    if ([value compare:@"TouchCancel" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventTouchCancel;
        return YES;
    }
    if ([value compare:@"ValueChanged" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventValueChanged;
        return YES;
    }
    if ([value compare:@"EditingDidBegin" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventEditingDidBegin;
        return YES;
    }
    if ([value compare:@"EditingChanged" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventEditingChanged;
        return YES;
    }
    if ([value compare:@"EditingDidEnd" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventEditingDidEnd;
        return YES;
    }
    if ([value compare:@"EditingDidEndOnExit" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        *event = UIControlEventEditingDidEndOnExit;
        return YES;
    }
    NSAssert(NO, @"Unknown control event: %@", value);
    return NO;
}

- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error
{
    if (value.statementType != NUIStatementType_Object) {
        *error = [NUIError errorWithData:value.data position:value.range.location
            message:@"Expecting an object."];
        return NO;
    }

    UIControlEvents event = 0;
    NSString *strEvent = [value property:@"event" ofClass:[NSString class]];
    if (![self controlEvent:&event fromNUIValue:strEvent]) {
        *error = [NUIError errorWithData:value.data position:value.range.location
            message:@"Expecting event string property."];
        return NO;
    }
    SEL selector = NSSelectorFromString([value property:@"selector" ofClass:[NSString class]]);

    id target = loader.rootObject;
    NSString *targetId = [value property:@"target" ofClass:[NSString class]];
    if (targetId) {
        target = [loader globalObjectForKey:targetId];
    }

    [self addTarget:target action:selector forControlEvents:event];
    return YES;
}

@end
