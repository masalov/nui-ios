//
//  NUIScrollView.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILayoutItem;

/*! A scroll view with only one subview, but with automatic \b contentSize calculation. If a
 *  scroller is disabled than the corresponding content size equals to the scroll view size.
 */
@interface NUIScrollView : UIScrollView

/*! Default value is \b NO. */
@property (nonatomic, assign) BOOL horizontalScrollerEnabled;
/*! Default value is \b YES. */
@property (nonatomic, assign) BOOL verticalScrollerEnabled;
/*! Default value is \b nil. */
@property (nonatomic, retain) UIView *contentView;
/*! By default vertical alignment is set to top. */
@property (nonatomic, readonly) NUILayoutItem *contentLayoutItem;

@end
