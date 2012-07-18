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

+ (NSDictionary *)nuiConstantsForAutoresizingMask
{
    static NSDictionary *autoresizingMaskConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        autoresizingMaskConstants = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleLeftMargin], @"FlexibleLeftMargin",
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleWidth], @"FlexibleWidth",
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleRightMargin], @"FlexibleRightMargin",
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleTopMargin], @"FlexibleTopMargin",
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleHeight], @"FlexibleHeight",
            [NSNumber numberWithInt:UIViewAutoresizingFlexibleBottomMargin], @"FlexibleBottomMargin",
            nil];
    });
    return autoresizingMaskConstants;
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
