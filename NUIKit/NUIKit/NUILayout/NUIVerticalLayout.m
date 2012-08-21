//
//  NUIVerticalLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "NUIVerticalLayout.h"
#import "NUILayoutItem.h"

@implementation NUIVerticalLayout

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    CGSize *sizes = (CGSize *)malloc(sizeof(CGSize) * self.subviews.count);
    __block CGFloat y = 0;
    __block CGFloat restSize = frame.size.height;
    __block int cStretchable = 0;
    __block CGSize constraintSize = frame.size;
    // Get preferred sizes and count of stretchable elements
    [self.subviews enumerateObjectsUsingBlock:^(id<NUIView> subview, NSUInteger idx, BOOL *stop) {
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
    [self.subviews enumerateObjectsUsingBlock:^(id<NUIView> subview, NSUInteger idx, BOOL *stop) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        if (item.verticalAlignment == NUIVerticalAlignment_Stretch && restSize > 0) {
            CGFloat additionalSize = floorf(restSize / cStretchable);
            sizes[idx].height += additionalSize;
            restSize -= additionalSize;
            --cStretchable;
        }
        [item placeInRect:CGRectMake(frame.origin.x, frame.origin.y + y, frame.size.width,
            sizes[idx].height) preferredSize:sizes[idx]];
        y += sizes[idx].height;
    }];
    free(sizes);
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    CGFloat width = 0, height = 0;
    for (id<NUIView> subview in self.subviews) {
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
