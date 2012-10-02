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

/*! A category to support loading of properties of \b UIButton from NUI that can't be loaded
 *  automatically.
 */
@interface UIButton (NUILoading)

/*! Allows to use \b title to load title for \b UIControlStateNormal state. */
@property (nonatomic, copy) NSString *title;
/*! Allows to use \b highlightedTitle to load title for \b UIControlStateHighlighted state. */
@property (nonatomic, copy) NSString *highlightedTitle;
/*! Allows to use \b disabledTitle to load title for \b UIControlStateDisabled state. */
@property (nonatomic, copy) NSString *disabledTitle;
/*! Allows to use \b selectedTitle to load title for \b UIControlStateSelected state. */
@property (nonatomic, copy) NSString *selectedTitle;

/*! Allows to use \b titleColor to load title color for \b UIControlStateNormal state. */
@property (nonatomic, retain) UIColor *titleColor;
/*! Allows to use \b highlightedTitleColor to load title color for \b UIControlStateHighlighted
 *  state.
 */
@property (nonatomic, retain) UIColor *highlightedTitleColor;
/*! Allows to use \b disabledTitleColor to load title color for \b UIControlStateDisabled state. */
@property (nonatomic, retain) UIColor *disabledTitleColor;
/*! Allows to use \b selectedTitleColor to load title color for \b UIControlStateSelected state. */
@property (nonatomic, retain) UIColor *selectedTitleColor;

/*! Allows to use \b titleShadowColor to load title shadow color for \b UIControlStateNormal state.
 */
@property (nonatomic, retain) UIColor *titleShadowColor;
/*! Allows to use \b highlightedTitleShadowColor to load title shadow color for
 *  \b UIControlStateHighlighted state.
 */
@property (nonatomic, retain) UIColor *highlightedTitleShadowColor;
/*! Allows to use \b disabledTitleShadowColor to load title shadow color for
 *  \b UIControlStateDisabled state.
 */
@property (nonatomic, retain) UIColor *disabledTitleShadowColor;
/*! Allows to use \b selectedTitleShadowColor to load title shadow color for
 *  \b UIControlStateSelected state.
 */
@property (nonatomic, retain) UIColor *selectedTitleShadowColor;

/*! Allows to use \b image to load image for \b UIControlStateNormal state. */
@property (nonatomic, retain) UIImage *image;
/*! Allows to use \b highlightedImage to load image for \b UIControlStateHighlighted state. */
@property (nonatomic, retain) UIImage *highlightedImage;
/*! Allows to use \b disabledImage to load image for \b UIControlStateDisabled state. */
@property (nonatomic, retain) UIImage *disabledImage;
/*! Allows to use \b selectedImage to load image for \b UIControlStateSelected state. */
@property (nonatomic, retain) UIImage *selectedImage;

/*! Allows to use \b backgroundImage to load background image for \b UIControlStateNormal state. */
@property (nonatomic, retain) UIImage *backgroundImage;
/*! Allows to use \b highlightedBackgroundImage to load background image for
 *  \b UIControlStateHighlighted state.
 */
@property (nonatomic, retain) UIImage *highlightedBackgroundImage;
/*! Allows to use \b disabledBackgroundImage to load background image for \b UIControlStateDisabled
 *  state.
 */
@property (nonatomic, retain) UIImage *disabledBackgroundImage;
/*! Allows to use \b selectedBackgroundImage to load background image for \b UIControlStateSelected
 *  state.
 */
@property (nonatomic, retain) UIImage *selectedBackgroundImage;

/*! Allows to use \b localizedTitle to load localized title for \b UIControlStateNormal state using
 *  \b NSLocalizedString function. */
- (void)setLocalizedTitle:(NSString *)localizedTitle;
/*! Allows to use \b localizedHighlightedTitle to load localized title for
 *  \b UIControlStateHighlighted state using \b NSLocalizedString function.
 */
- (void)setLocalizedHighlightedTitle:(NSString *)localizedHighlightedTitle;
/*! Allows to use \b localizedDisabledTitle to load localized title for \b UIControlStateDisabled
 *  state using \b NSLocalizedString function.
 */
- (void)setLocalizedDisabledTitle:(NSString *)localizedDisabledTitle;
/*! Allows to use \b localizedSelectedTitle to load localized title for \b UIControlStateSelected
 *  state using \b NSLocalizedString function.
 */
- (void)setLocalizedSelectedTitle:(NSString *)localizedSelectedTitle;

/*! Overrides \b UIControl method making \b event property optional and using
 *  \b UIControlEventTouchUpInside by default.
 */
- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
