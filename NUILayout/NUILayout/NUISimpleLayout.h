//
//  NUISimpleLayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayout.h"

// Base class for layouts that works with NUILayoutItem (not with a subclass of it)
@interface NUISimpleLayout : NUILayout

- (NUILayoutItem *)addSubview:(UIView *)view;
- (NUILayoutItem *)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;
- (NUILayoutItem *)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview;

@end