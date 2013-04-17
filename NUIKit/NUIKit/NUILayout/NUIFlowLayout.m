//
//  NUIFlowLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUIFlowLayout.h"
#import "NUILayoutItem.h"

@implementation NUIFlowLayout

- (void)layoutInRect:(CGRect)rect
{
    CGFloat y = 0;
    for (int firstView = 0; firstView < self.subviews.count;) {
        NSMutableArray *sizes = [[NSMutableArray alloc] init];
        int nextFirstView = firstView;
        CGFloat width = 0;
        for (; nextFirstView < self.subviews.count; ++nextFirstView) {
            id<NUIView> view = [self.subviews objectAtIndex:nextFirstView];
            NUILayoutItem *item = [self layoutItemForSubview:view];
            CGSize sz = [item sizeWithMarginThatFits:(CGSize){rect.size.width - width,
                rect.size.height - y}];

            if (width + sz.width > rect.size.width) {
                if (nextFirstView == firstView) {
                    [sizes addObject:[NSValue valueWithCGSize:sz]];
                    ++nextFirstView;
                }
                break;
            }
            [sizes addObject:[NSValue valueWithCGSize:sz]];
            width += sz.width;
        }
        CGFloat maxHeight = 0;
        for (NSValue *val in sizes) {
            if ([val CGSizeValue].height > maxHeight) {
                maxHeight = [val CGSizeValue].height;
            }
        }
        CGFloat x = 0;
        for (int i = firstView; i < nextFirstView; ++i) {
            id<NUIView> view = [self.subviews objectAtIndex:i];
            NUILayoutItem *item = [self layoutItemForSubview:view];
            CGSize sz = [[sizes objectAtIndex:i - firstView] CGSizeValue];
            [item placeInRect:(CGRect){rect.origin.x + x, rect.origin.y + y, sz.width, maxHeight}
                preferredSize:sz];
            x += sz.width;
        }
        y += maxHeight;
        firstView = nextFirstView;
    }
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    CGFloat y = 0;
    for (int firstView = 0; firstView < self.subviews.count;) {
        int nextFirstView = firstView;
        CGFloat width = 0;
        CGFloat maxHeight = 0;
        for (; nextFirstView < self.subviews.count; ++nextFirstView) {
            id<NUIView> view = [self.subviews objectAtIndex:nextFirstView];
            NUILayoutItem *item = [self layoutItemForSubview:view];
            CGSize sz = [item sizeWithMarginThatFits:(CGSize){size.width - width, size.height - y}];

            if (width + sz.width > size.width) {
                if (nextFirstView == firstView) {
                    ++nextFirstView;
                    if (maxHeight < sz.height) {
                        maxHeight = sz.height;
                    }
                }
                break;
            }
            width += sz.width;
            if (maxHeight < sz.height) {
                maxHeight = sz.height;
            }
        }
        y += maxHeight;
        firstView = nextFirstView;
    }
    return CGSizeMake(size.width, y);
}

@end
