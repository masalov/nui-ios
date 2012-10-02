//
//  UIButton+NUILayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 8/22/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! Overrides \b preferredSizeThatFits: method. */
@interface UIButton (NUILayout)

- (CGSize)preferredSizeThatFits:(CGSize)size;

@end