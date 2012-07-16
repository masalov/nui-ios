//
//  UIView+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIView+NUILoading.h"
#import "NUILoader.h"
#import "NUIIdentifier.h"
#import "NUIObject.h"

#import "nui_utils.h"

@implementation UIView (NUILoading)

@dynamic backgroundColor;

- (BOOL)setNUIAutoresizingMask:(NSString *)value
{
    if (![value isKindOfClass:[NUIIdentifier class]]) {
        NSAssert(NO, @"Invalid format.");
        return NO;
    }
    NSArray *components = [value componentsSeparatedByString:@"|"];
    UIViewAutoresizing autoresizing = 0;
    for (NSString *component in components) {
        if ([component compare:@"FlexibleLeftMargin"
                       options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleLeftMargin;
        } else if ([component compare:@"FlexibleWidth"
                              options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleWidth;
        } else if ([component compare:@"FlexibleRightMargin"
                              options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleRightMargin;
        } else if ([component compare:@"FlexibleTopMargin"
                              options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleTopMargin;
        } else if ([component compare:@"FlexibleHeight"
                              options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleHeight;
        } else if ([component compare:@"FlexibleBottomMargin"
                              options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            autoresizing |= UIViewAutoresizingFlexibleBottomMargin;
        } else {
            NSAssert(NO, @"Unknown autoresizing: %@", component);
            return NO;
        }
    }
    self.autoresizingMask = autoresizing;
    return YES;
}


- (BOOL)loadNUISubviewsFromRValue:(NSArray *)array loader:(NUILoader *)loader
{
    if (![array isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Subviews should be array.");
        return NO;
    }
    for (NUIObject *object in array) {
        if (![object isKindOfClass:[NUIObject class]]) {
            NSAssert(NO, @"Subview should be dictionary.");
            return NO;
        }
        UIView *subview = [loader loadObjectOfClass:[UIView class] fromNUIObject:object];
        if (subview) {
            [self addSubview:subview];
        } else {
            NSAssert(NO, @"Failed to load subview.");
            return NO;
        }
    }
    return YES;
}

@end
