//
//  UIImage+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUIError;
@class NUILoader;

@interface UIImage (NUILoading)

// Loads image from a NUI element. File attribute is mandatory. Optional attributes are leftCapWidth
// and topCapHeight.
+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
