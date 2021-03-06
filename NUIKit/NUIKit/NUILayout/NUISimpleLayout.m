//
//  NUISimpleLayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUISimpleLayout.h"
#import "NUILayoutItem.h"

@implementation NUISimpleLayout

- (NUILayoutItem *)addSubview:(id<NUIView>)view
{
    NUILayoutItem *layoutItem = [[NUILayoutItem alloc] init];
    [self addSubview:view layoutItem:layoutItem];
    return layoutItem;
}

- (NUILayoutItem *)insertSubview:(id<NUIView>)view belowSubview:(UIView *)siblingSubview
{
    NUILayoutItem *layoutItem = [[NUILayoutItem alloc] init];
    [self insertSubview:view belowSubview:siblingSubview layoutItem:layoutItem];
    return layoutItem;
}

- (NUILayoutItem *)insertSubview:(id<NUIView>)view aboveSubview:(UIView *)siblingSubview
{
    NUILayoutItem *layoutItem = [[NUILayoutItem alloc] init];
    [self insertSubview:view aboveSubview:siblingSubview layoutItem:layoutItem];
    return layoutItem;
}

@end

