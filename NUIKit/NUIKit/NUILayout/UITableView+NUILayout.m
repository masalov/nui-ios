//
//  UITableView+NUILayout.m
//  NUILayout
//
//  Created by Ivan Masalov on 8/31/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "UITableView+NUILayout.h"

@implementation UITableView (NUILayout)

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return [self sizeThatFits:size];
}

@end