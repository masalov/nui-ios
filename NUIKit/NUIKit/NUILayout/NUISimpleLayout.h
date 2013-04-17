//
//  NUISimpleLayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUILayout.h"

/*! Base class for layouts that works with \b NUILayoutItem (not with a subclass of it). */
@interface NUISimpleLayout : NUILayout

/*! Adds view to layout. */
- (NUILayoutItem *)addSubview:(id<NUIView>)view;
/*! Inserts view to layout below \b siblingSubview. */
- (NUILayoutItem *)insertSubview:(id<NUIView>)view belowSubview:(UIView *)siblingSubview;
/*! Inserts view to layout above \b siblingSubview. */
- (NUILayoutItem *)insertSubview:(id<NUIView>)view aboveSubview:(UIView *)siblingSubview;

@end