//
//  NUIFlowLayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayout.h"

@class NUILayoutItem;

// Layouts subview in horizontal lines.
// Lines are directed from the left to the right. First line is top one.
@interface NUIFlowLayout : NUILayout

- (NUILayoutItem *)addSubview:(UIView *)view;

@end
