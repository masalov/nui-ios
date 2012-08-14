//
//  UIButton+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUILoader;
@class NUIError;

@interface UIButton (NUILoading)

// Title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *localizedTitle;

@property (nonatomic, copy) NSString *highlightedTitle;
@property (nonatomic, copy) NSString *localizedHighlightedTitle;


@property (nonatomic, copy) NSString *disabledTitle;
@property (nonatomic, copy) NSString *localizedDisabledTitle;

@property (nonatomic, copy) NSString *selectedTitle;
@property (nonatomic, copy) NSString *localizedSelectedTitle;

// Title color
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *highlightedTitleColor;
@property (nonatomic, retain) UIColor *disabledTitleColor;
@property (nonatomic, retain) UIColor *selectedTitleColor;

// Title shadow color
@property (nonatomic, retain) UIColor *titleShadowColor;
@property (nonatomic, retain) UIColor *highlightedTitleShadowColor;
@property (nonatomic, retain) UIColor *disabledTitleShadowColor;
@property (nonatomic, retain) UIColor *selectedTitleShadowColor;

// Image
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *highlightedImage;
@property (nonatomic, retain) UIImage *disabledImage;
@property (nonatomic, retain) UIImage *selectedImage;

// Background image
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *highlightedBackgroundImage;
@property (nonatomic, retain) UIImage *disabledBackgroundImage;
@property (nonatomic, retain) UIImage *selectedBackgroundImage;

// Overrides UIControl method for using UIControlEventTouchUpInside as default event
- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
