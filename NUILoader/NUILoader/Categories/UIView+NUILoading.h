//
//  UIView+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILoader;
@class NUIIdentifier;

@interface UIView (NUILoading)

@property (nonatomic, copy) UIColor *backgroundColor;

+ (NSDictionary *)nuiConstantsForAutoresizingMask;

- (BOOL)loadNUISubviewsFromRValue:(NSArray *)array loader:(NUILoader *)loader;

@end
