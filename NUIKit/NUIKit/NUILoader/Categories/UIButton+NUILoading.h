//
//  UIButton+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIObject;
@class NUILoader;

@interface UIButton (NUILoading)

// Title
- (BOOL)setNUITitle:(NSString *)value;
- (BOOL)setNUILocalizedTitle:(NSString *)value;

- (BOOL)setNUIHighlightedTitle:(NSString *)value;
- (BOOL)setNUILocalizedHighlightedTitle:(NSString *)value;

- (BOOL)setNUIDisabledTitle:(NSString *)value;
- (BOOL)setNUILocalizedDisabledTitle:(NSString *)value;

- (BOOL)setNUISelectedTitle:(NSString *)value;
- (BOOL)setNUILocalizedSelectedTitle:(NSString *)value;

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
- (BOOL)loadNUIActionFromRValue:(NUIObject *)value loader:(NUILoader *)loader;

@end
