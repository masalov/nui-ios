//
//  NUILayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayout.h"
#import "NUILayoutItem.h"
#import "UIView+NUILayout.h"

@interface NUILayout ()
{
    NSMutableArray *subviews_;
    NSMutableDictionary *layoutItems_;
}

- (void)setLayoutItem:(NUILayoutItem *)layoutItem forSubview:(UIView *)subview;
- (void)removeLayoutItemForSubview:(UIView *)subview;

@end

@implementation NUILayout

@synthesize view = view_;

- (id)init
{
    self = [super init];
    if (self) {
        layoutItems_ = [[NSMutableDictionary alloc] init];
        subviews_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [subviews_ release];
    [layoutItems_ release];
    [super dealloc];
}

- (void)addSubview:(UIView *)view layoutItem:(NUILayoutItem *)layoutItem
{
    [subviews_ addObject:view];
    [self.view addSubview:view];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)insertSubview:(UIView *)view
         belowSubview:(UIView *)siblingSubview
           layoutItem:(NUILayoutItem *)layoutItem
{
    [subviews_ insertObject:view atIndex:[subviews_ indexOfObject:siblingSubview]];
    [self.view insertSubview:view belowSubview:siblingSubview];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)insertSubview:(UIView *)view
         aboveSubview:(UIView *)siblingSubview
           layoutItem:(NUILayoutItem *)layoutItem
{
    [subviews_ insertObject:view atIndex:[subviews_ indexOfObject:siblingSubview] + 1];
    [self.view insertSubview:view aboveSubview:siblingSubview];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)removeSubview:(UIView *)view
{
    [subviews_ removeObject:view];
    [view removeFromSuperview];
    [self removeLayoutItemForSubview:view];
}

- (NSArray *)subviews
{
    return subviews_;
}

- (NUILayoutItem *)createLayoutItem
{
    return [[[NUILayoutItem alloc] init] autorelease];
}

- (NUILayoutItem *)layoutItemForSubview:(UIView *)subview
{
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    return [layoutItems_ objectForKey:key];
}

- (void)layoutForSize:(CGSize)size
{
    for (UIView *subview in self.subviews) {
        subview.needsToUpdateSize = NO;
    }
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return CGSizeZero;
}

#pragma private - methods

- (void)setLayoutItem:(NUILayoutItem *)layoutItem forSubview:(UIView *)subview
{
    layoutItem.view = subview;
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    [layoutItems_ setObject:layoutItem forKey:key];
}

- (void)removeLayoutItemForSubview:(UIView *)subview
{
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    return [layoutItems_ removeObjectForKey:key];
}

@end
