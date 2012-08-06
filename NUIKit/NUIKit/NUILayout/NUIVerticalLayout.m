//
//  NUIVerticalLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIVerticalLayout.h"
#import "NUILayoutItem.h"
#import "UIView+NUILayout.h"

@implementation NUIVerticalLayout

- (void)layoutForSize:(CGSize)size
{
    [super layoutForSize:size];

    CGSize *sizes = (CGSize *)malloc(sizeof(CGSize) * self.subviews.count);
    __block CGFloat y = 0;
    __block CGFloat restSize = size.height;
    __block int cStretchable = 0;
    __block CGSize constraintSize = size;
    // Get preferred sizes and count of stretchable elements
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        sizes[idx] = [item sizeWithMarginThatFits:constraintSize];
        restSize -= sizes[idx].height;
        if (item.verticalAlignment == NUIVerticalAlignment_Stretch) {
            ++cStretchable;
        }
        if (constraintSize.height < sizes[idx].height) {
            constraintSize.height = 0;
        } else {
            constraintSize.height -= sizes[idx].height;
        }
    }];
    // layout elements
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        if (item.verticalAlignment == NUIVerticalAlignment_Stretch && restSize > 0) {
            CGFloat additionalSize = floorf(restSize / cStretchable);
            sizes[idx].height += additionalSize;
            restSize -= additionalSize;
            --cStretchable;
        }
        [item placeInRect:CGRectMake(0, y, size.width, sizes[idx].height)
            preferredSize:sizes[idx]];
        y += sizes[idx].height;
    }];
    free(sizes);
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    CGFloat width = 0, height = 0;
    for (UIView *subview in self.subviews) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        CGSize sz = [item sizeWithMarginThatFits:size];
        if (width < sz.width) {
            width = sz.width;
        }
        height += sz.height;
        if (size.height < sz.height) {
            size.height = 0;
        } else {
            size.height -= sz.height;
        }
    }
    return CGSizeMake(width, height);
}

@end
