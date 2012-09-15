//
//  NUILayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUIView.h"

@class NUILayoutView;
@class NUILayoutItem;

// Base class for layouts. Each layout has subviews and corresponding layout items.
// Adding/removing subview should cause adding/removing subview to current view.
// Override setFrame to implement layouting.
@interface NUILayout : NSObject <NUIView>

@property (nonatomic, assign) NUILayoutView *superview;
@property(nonatomic,getter=isHidden) BOOL hidden;
@property (nonatomic, assign) BOOL needsToUpdateSize;

- (void)addSubview:(id<NUIView>)view layoutItem:(NUILayoutItem *)layoutItem;
- (void)insertSubview:(id<NUIView>)view belowSubview:(UIView *)siblingSubview
    layoutItem:(NUILayoutItem *)layoutItem;
- (void)insertSubview:(id<NUIView>)view aboveSubview:(UIView *)siblingSubview
    layoutItem:(NUILayoutItem *)layoutItem;
- (void)removeSubview:(id<NUIView>)view;

// Array of NUIView objects.
- (NSArray *)subviews;

// Override if custom layout item is needed. Don't forget to set layout property.
- (NUILayoutItem *)createLayoutItem;
- (NUILayoutItem *)layoutItemForSubview:(id<NUIView>)subview;
// Searches in sublayouts.
- (NUILayoutItem *)layoutItemForSubview:(id<NUIView>)subview recursively:(BOOL)recursively;

// Returns CGSizeZero by default.
- (CGSize)preferredSizeThatFits:(CGSize)size;

@end
