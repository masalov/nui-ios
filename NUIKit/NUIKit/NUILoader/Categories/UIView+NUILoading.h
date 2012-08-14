//
//  UIView+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUILoader;
@class NUIStatement;
@class NUIError;

@interface UIView (NUILoading)

@property (nonatomic, copy) UIColor *backgroundColor;

+ (NSDictionary *)nuiConstantsForAutoresizingMask;

- (BOOL)loadNUISubviewsFromRValue:(NUIStatement *)array loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
