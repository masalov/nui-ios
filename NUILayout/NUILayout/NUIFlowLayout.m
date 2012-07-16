//
//  NUIFlowLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIFlowLayout.h"
#import "NUILayoutItem.h"

@implementation NUIFlowLayout

- (NUILayoutItem *)addSubview:(UIView *)view
{
    NUILayoutItem *layoutItem = [[[NUILayoutItem alloc] init] autorelease];
    [self addSubview:view layoutItem:layoutItem];
    return layoutItem;
}

- (void)layoutForSize:(CGSize)size
{
    CGFloat y = 0;
    for (int firstView = 0; firstView < self.subviews.count;) {
        id pool = [[NSAutoreleasePool alloc] init];

        NSMutableArray *sizes = [[[NSMutableArray alloc] init] autorelease];
        int nextFirstView = firstView;
        CGFloat width = 0;
        for (; nextFirstView < self.subviews.count; ++nextFirstView) {
            UIView *view = [self.subviews objectAtIndex:nextFirstView];
            NUILayoutItem *item = [self layoutItemForSubview:view];
            CGSize sz = [item sizeWithMarginThatFits:(CGSize){size.width - width, size.height - y}];

            if (width + sz.width > size.width) {
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
            UIView *view = [self.subviews objectAtIndex:i];
            NUILayoutItem *item = [self layoutItemForSubview:view];
            CGSize sz = [[sizes objectAtIndex:i - firstView] CGSizeValue];
            [item placeInRect:(CGRect){x, y, sz.width, maxHeight}
                preferredSize:sz];
            x += sz.width;
        }
        y += maxHeight;
        firstView = nextFirstView;

        [pool release];
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
            UIView *view = [self.subviews objectAtIndex:nextFirstView];
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
