//
//  NUIHorizontalLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "NUIHorizontalLayout.h"
#import "NUILayoutItem.h"

@implementation NUIHorizontalLayout

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    CGSize *sizes = (CGSize *)malloc(sizeof(CGSize) * self.subviews.count);
    __block CGFloat x = 0;
    __block CGFloat restSize = frame.size.width;
    __block int cStretchable = 0;
    __block CGSize constraintSize = frame.size;
    // Get preferred sizes and count of stretchable elements
    [self.subviews enumerateObjectsUsingBlock:^(id<NUIView> subview, NSUInteger idx, BOOL *stop) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        sizes[idx] = [item sizeWithMarginThatFits:constraintSize];
        restSize -= sizes[idx].width;
        if (item.horizontalAlignment == NUIHorizontalAlignment_Stretch) {
            ++cStretchable;
        }
        if (constraintSize.width < sizes[idx].width) {
            constraintSize.width = 0;
        } else {
            constraintSize.width -= sizes[idx].width;
        }
    }];
    // layout elements
    [self.subviews enumerateObjectsUsingBlock:^(id<NUIView> subview, NSUInteger idx, BOOL *stop) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        if (item.horizontalAlignment == NUIHorizontalAlignment_Stretch) {
            CGFloat additionalSize = floorf(restSize / cStretchable);
            sizes[idx].width += additionalSize;
            restSize -= additionalSize;
            --cStretchable;
        }
        [item placeInRect:CGRectMake(frame.origin.x + x, frame.origin.y, sizes[idx].width,
            frame.size.height) preferredSize:sizes[idx]];
        x += sizes[idx].width;
    }];
    free(sizes);
}



- (CGSize)preferredSizeThatFits:(CGSize)size
{
    CGFloat width = 0, height = 0;
    for (id<NUIView> subview in self.subviews) {
        NUILayoutItem *item = [self layoutItemForSubview:subview];
        CGSize sz = [item sizeWithMarginThatFits:size];
        width += sz.width;
        if (size.width < sz.width) {
            size.width = 0;
        } else {
            size.width -= sz.width;
        }
        if (height < sz.height) {
            height = sz.height;
        }
    }
    return CGSizeMake(width, height);
}

@end
