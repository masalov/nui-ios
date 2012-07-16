//
//  UIControl+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIObject;
@class NUILoader;

@interface UIControl (NUILoading)

- (BOOL)controlEvent:(UIControlEvents *)event fromNUIValue:(NSString *)value;
- (BOOL)loadNUIActionFromRValue:(NUIObject *)value loader:(NUILoader *)loader;

@end
