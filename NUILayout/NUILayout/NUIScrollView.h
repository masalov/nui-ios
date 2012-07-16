//
//  NUIScrollView.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILayoutItem;

// Scrollview with automatic contentSize calculation
// If scroller is disabled than corresponding content size equals to scollview size
@interface NUIScrollView : UIScrollView

//  Default value is NO
@property (nonatomic, assign) BOOL horizontalScrollerEnabled;
//  Default value is NO
@property (nonatomic, assign) BOOL verticalScrollerEnabled;

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, readonly) NUILayoutItem *contentLayoutItem;

@end
