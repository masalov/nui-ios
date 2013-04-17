//
//  UIButton+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "UIButton+NUILoading.h"
#import "UIControl+NUILoading.h"
#import "NUIStatement+Object.h"
#import "NUILoader.h"
#import "NUIError.h"

@implementation UIButton (NUILoading)

// Title

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title
{
    return [self titleForState:UIControlStateNormal];
}

- (void)setHighlightedTitle:(NSString *)highlightedTitle
{
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)highlightedTitle
{
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setDisabledTitle:(NSString *)disabledTitle
{
    [self setTitle:disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)disabledTitle
{
    return [self titleForState:UIControlStateDisabled];
}

- (void)setSelectedTitle:(NSString *)selectedTitle
{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (NSString *)selectedTitle
{
    return [self titleForState:UIControlStateSelected];
}

// Title color

- (void)setTitleColor:(UIColor *)titleColor
{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColor
{
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleColor
{
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setDisabledTitleColor:(UIColor *)disabledTitleColor
{
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)disabledTitleColor
{
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}

// Title shadow color

- (void)setTitleShadowColor:(UIColor *)titleShadowColor
{
    [self setTitleShadowColor:titleShadowColor forState:UIControlStateNormal];
}

- (UIColor *)titleShadowColor
{
    return [self titleShadowColorForState:UIControlStateNormal];
}

- (void)setHighlightedTitleShadowColor:(UIColor *)highlightedTitleShadowColor
{
    [self setTitleShadowColor:highlightedTitleShadowColor forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateHighlighted];
}

- (void)setDisabledTitleShadowColor:(UIColor *)disabledTitleShadowColor
{
    [self setTitleShadowColor:disabledTitleShadowColor forState:UIControlStateDisabled];
}

- (UIColor *)disabledTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateDisabled];
}

- (void)setSelectedTitleShadowColor:(UIColor *)selectedTitleShadowColor
{
    [self setTitleShadowColor:selectedTitleShadowColor forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateSelected];
}

// Image

- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)image
{
    return [self imageForState:UIControlStateNormal];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)highlightedImage
{
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setDisabledImage:(UIImage *)disabledImage
{
    [self setImage:disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)disabledImage
{
    return [self imageForState:UIControlStateDisabled];
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (UIImage *)selectedImage
{
    return [self imageForState:UIControlStateSelected];
}

// Background Image

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (UIImage *)backgroundImage
{
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)highlightedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage
{
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)disabledBackgroundImage
{
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}

- (UIImage *)selectedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateSelected];
}

// Localized title

- (void)setLocalizedTitle:(NSString *)localizedTitle
{
    [self setTitle:NSLocalizedString(localizedTitle, nil) forState:UIControlStateNormal];
}

- (void)setLocalizedHighlightedTitle:(NSString *)localizedHighlightedTitle
{
    [self setTitle:NSLocalizedString(localizedHighlightedTitle, nil)
        forState:UIControlStateHighlighted];
}

- (void)setLocalizedDisabledTitle:(NSString *)localizedDisabledTitle
{
    [self setTitle:NSLocalizedString(localizedDisabledTitle, nil) forState:UIControlStateDisabled];
}

- (void)setLocalizedSelectedTitle:(NSString *)localizedSelectedTitle
{
    [self setTitle:NSLocalizedString(localizedSelectedTitle, nil) forState:UIControlStateSelected];
}

- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error
{
    if (value.statementType != NUIStatementType_Object) {
        *error = [NUIError errorWithData:value.data position:value.range.location
            message:@"Expecting an object."];
        return NO;
    }

    UIControlEvents event = UIControlEventTouchUpInside;
    NSString *strEvent = [value property:@"event" ofClass:[NSString class] error:error];
    if (strEvent && ![self controlEvent:&event fromNUIValue:strEvent]) {
        *error = [NUIError errorWithData:value.data position:value.range.location
            message:@"Invalid value."];
        return NO;
    }
    
    SEL selector = NSSelectorFromString([value property:@"selector" ofClass:[NSString class]
        error:error]);
    if (!selector) {
        return NO;
    }

    id target = loader.rootObject;
    NSString *targetId = [value property:@"target" ofClass:[NSString class] error:error];
    if (targetId) {
        target = [loader globalObjectForKey:targetId];
    }

    [self addTarget:target action:selector forControlEvents:event];
    return YES;
}

@end
