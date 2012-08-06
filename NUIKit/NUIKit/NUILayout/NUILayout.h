//
//  NUILayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILayoutItem;

// Base class for layouts.
// Each layout has subviews and corresponding layout items.
// Adding/removing subview should cause adding/removing subview to current view.
@interface NUILayout : NSObject

@property (nonatomic, assign) UIView *view;

- (void)addSubview:(UIView *)view layoutItem:(NUILayoutItem *)layoutItem;
- (void)insertSubview:(UIView *)view
         belowSubview:(UIView *)siblingSubview
           layoutItem:(NUILayoutItem *)layoutItem;
- (void)insertSubview:(UIView *)view
         aboveSubview:(UIView *)siblingSubview
           layoutItem:(NUILayoutItem *)layoutItem;
- (void)removeSubview:(UIView *)view;

- (NSArray *)subviews;

- (NUILayoutItem *)createLayoutItem;
- (NUILayoutItem *)layoutItemForSubview:(UIView *)subview;

// For override
// does nothing by default
- (void)layoutForSize:(CGSize)size;
// returns CGSizeZero by default
- (CGSize)preferredSizeThatFits:(CGSize)size;

@end
