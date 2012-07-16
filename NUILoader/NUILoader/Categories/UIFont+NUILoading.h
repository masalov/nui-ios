//
//  UIFont+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIObject;
@class NUILoader;

@interface UIFont (NUILoading)

// Loads font from a NUI element. Size attribute is mandatory. If no other attributes normal system
// font is used. Specify type attribute to use bold, italic or normal system font. To load font with
// specific name set name attribute.
+ (id)loadFromNUIObject:(NUIObject *)nuiObject loader:(NUILoader *)loader;

@end
