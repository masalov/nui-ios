//
//  UIView+NUILayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 8/20/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILayoutView;
@class NUILayoutItem;

// This protocol is implemented by NUILayout and UIView so they can be treated equally by a
// containing layout.
@protocol NUIView <NSObject>

// Layout objects monitor this option to update layout and set their needsToUpdateSize to YES
// so parent layout will update layout too
@property (nonatomic, assign) BOOL needsToUpdateSize;

// If superView is NUILayoutView and its layout is set than returns a layout item from the layout
// that corresponds to this view. Otherwise returns nil.
- (NUILayoutItem *)layoutItem;

// sizeThatFits: returns current size by default, it is not good behaviour
// preferredSizeThatFits: by default returns min size
- (CGSize)preferredSizeThatFits:(CGSize)size;

- (UIView *)superview;
- (void)setFrame:(CGRect)frame;
- (BOOL)isHidden;
- (void)setHidden:(BOOL)hidden;

- (void)addToView:(NUILayoutView *)view;
- (void)insertIntoView:(NUILayoutView *)view belowSubview:(UIView *)siblingSubview;
- (void)insertIntoView:(NUILayoutView *)view aboveSubview:(UIView *)siblingSubview
    lastInsertedSubview:(UIView **)lastSubview;
- (void)removeFromSuperview;

@end