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
#import "NUILayoutView.h"

@interface NUILayout ()
{
    NSMutableArray *subviews_;
    NSMutableDictionary *layoutItems_;
}

- (void)setLayoutItem:(NUILayoutItem *)layoutItem forSubview:(id<NUIView>)subview;
- (void)removeLayoutItemForSubview:(id<NUIView>)subview;

@end

@implementation NUILayout

@synthesize superview = superview_;
@synthesize hidden = hidden_;

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

#pragma mark - Properties

- (void)setNeedsToUpdateSize:(BOOL)needsToUpdateSize
{
    if (needsToUpdateSize) {
        self.superview.needsToUpdateSize = YES;
        [self.superview setNeedsLayout];
    }
}

- (BOOL)needsToUpdateSize
{
    return NO;
}

- (NUILayoutItem *)layoutItem
{
    return  [[self.superview layout] layoutItemForSubview:self recursively:YES];
}

- (void)setFrame:(CGRect)frame
{
    for (id<NUIView> subview in self.subviews) {
        subview.needsToUpdateSize = NO;
    }
}

- (void)addToView:(NUILayoutView *)view
{
    self.superview = view;
    for (id<NUIView> subview in subviews_) {
        [subview addToView:view];
    }
}

- (void)insertIntoView:(NUILayoutView *)view belowSubview:(UIView *)siblingSubview
{
    self.superview = view;
    for (id<NUIView> subview in subviews_) {
        [subview insertIntoView:view belowSubview:siblingSubview];
    }
}

- (void)insertIntoView:(NUILayoutView *)view aboveSubview:(UIView *)siblingSubview
    lastInsertedSubview:(UIView **)lastSubview
{
    self.superview = view;
    for (id<NUIView> subview in subviews_) {
        [subview insertIntoView:view aboveSubview:siblingSubview
            lastInsertedSubview:&siblingSubview];
    }
    if (lastSubview) {
        *lastSubview = siblingSubview;
    }
}

- (void)removeFromSuperview
{
    self.superview = nil;
    for (id<NUIView> subview in subviews_) {
        [subview removeFromSuperview];
    }
}

#pragma mark - Public methods

- (void)addSubview:(id<NUIView>)view layoutItem:(NUILayoutItem *)layoutItem
{
    if ([self layoutItemForSubview:view]) {
        [self removeSubview:view];
    }
    [subviews_ addObject:view];
    [view addToView:superview_];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)insertSubview:(id<NUIView>)view belowSubview:(UIView *)siblingSubview
    layoutItem:(NUILayoutItem *)layoutItem
{
    [subviews_ insertObject:view atIndex:[subviews_ indexOfObject:siblingSubview]];
    [view insertIntoView:superview_ belowSubview:siblingSubview];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)insertSubview:(id<NUIView>)view aboveSubview:(UIView *)siblingSubview
    layoutItem:(NUILayoutItem *)layoutItem
{
    [subviews_ insertObject:view atIndex:[subviews_ indexOfObject:siblingSubview] + 1];
    [view insertIntoView:superview_ aboveSubview:siblingSubview lastInsertedSubview:nil];
    [self setLayoutItem:layoutItem forSubview:view];
}

- (void)removeSubview:(id<NUIView>)view
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
    NUILayoutItem *item = [[[NUILayoutItem alloc] init] autorelease];
    item.layout = self;
    return item;
}

- (NUILayoutItem *)layoutItemForSubview:(id<NUIView>)subview
{
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    return [layoutItems_ objectForKey:key];
}

- (NUILayoutItem *)layoutItemForSubview:(id<NUIView>)subview recursively:(BOOL)recursively
{
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    NUILayoutItem *item = [layoutItems_ objectForKey:key];
    if (!item) {
        for (NUILayout *sublayout in subviews_) {
            if ([sublayout isKindOfClass:[NUILayout class]]) {
                if ((item = [sublayout layoutItemForSubview:subview recursively:recursively])) {
                    break;
                }
            }
        }
    }
    return item;
}


- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return CGSizeZero;
}

#pragma private - methods

- (void)setLayoutItem:(NUILayoutItem *)layoutItem forSubview:(id<NUIView>)subview
{
    layoutItem.view = subview;
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    [layoutItems_ setObject:layoutItem forKey:key];
}

- (void)removeLayoutItemForSubview:(id<NUIView>)subview
{
    NSString *key = [[[NSString alloc] initWithFormat:@"%p", subview] autorelease];
    return [layoutItems_ removeObjectForKey:key];
}

@end
