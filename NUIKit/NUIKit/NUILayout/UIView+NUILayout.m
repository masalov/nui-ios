//
//  UIView+NUILayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIView+NUILayout.h"
#import <objc/runtime.h>
#import "NUILayoutView.h"
#import "NUILayout.h"
#import "NUILayoutItem.h"

static int NeedsToUpdateSizeKey;

@implementation UIView (NUILayout)

- (void)setNeedsToUpdateSize:(BOOL)needsToUpdateSize
{
    NSNumber *value = [NSNumber numberWithBool:needsToUpdateSize];
    objc_setAssociatedObject(self, &NeedsToUpdateSizeKey, value,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needsToUpdateSize
{
    NSNumber *value = objc_getAssociatedObject(self, &NeedsToUpdateSizeKey);
    return [value boolValue];
}

- (NUILayoutItem *)layoutItem
{
    if ([self.superview isKindOfClass:[NUILayoutView class]]) {
        return  [[(NUILayoutView *)self.superview layout] layoutItemForSubview:self
            recursively:YES];
    }
    return nil;
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return CGSizeZero;
}

- (void)addToView:(NUILayoutView *)view
{
    [view addSubview:self];
}

- (void)insertIntoView:(NUILayoutView *)view belowSubview:(UIView *)siblingSubview
{
    [view insertSubview:self belowSubview:siblingSubview];
}

- (void)insertIntoView:(NUILayoutView *)view aboveSubview:(UIView *)siblingSubview
    lastInsertedSubview:(UIView **)lastSubview
{
    [view insertSubview:self aboveSubview:siblingSubview];
    if (lastSubview) {
        *lastSubview = self;
    }
}

@end
