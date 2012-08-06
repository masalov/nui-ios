//
//  NUILayoutView.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILayout;
@class NUILayoutAnimation;

// View with layout. Sets autoresizesSubviews to NO
// and monitors needsToUpdateSize property of subviews.
// Do not add subviews via UIView methods, use layout methods.
@interface NUILayoutView : UIView

// Changing this property causes removing subviews from old layout
// and adding from new one
@property (nonatomic, retain) NUILayout *layout;

// If not nil subviews layouting will be animated
@property (nonatomic, retain) NUILayoutAnimation *layoutAnimation;

@end
