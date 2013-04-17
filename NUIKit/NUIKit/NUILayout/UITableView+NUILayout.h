//
//  UITableView+NUILayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 8/31/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! Overrides \b preferredSizeThatFits: method. */
@interface UITableView (NUILayout)

- (CGSize)preferredSizeThatFits:(CGSize)size;

@end