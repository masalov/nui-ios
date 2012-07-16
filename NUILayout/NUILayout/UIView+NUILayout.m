//
//  UIView+NUILayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIView+NUILayout.h"
#import <objc/runtime.h>

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

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return CGSizeZero;
}

@end
