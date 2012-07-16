//
//  UIButton+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIButton+NUILoading.h"
#import "UIControl+NUILoading.h"
#import "NUIObject.h"
#import "NUIIdentifier.h"
#import "NUILoader.h"

@implementation UIButton (NUILoading)

// Title

- (BOOL)setNUITitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:value forState:UIControlStateNormal];
    return YES;
}

- (BOOL)setNUILocalizedTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:NSLocalizedString(value, nil) forState:UIControlStateNormal];
    return YES;
}

- (BOOL)setNUIHighlightedTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:value forState:UIControlStateHighlighted];
    return YES;
}

- (BOOL)setNUILocalizedHighlightedTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:NSLocalizedString(value, nil) forState:UIControlStateHighlighted];
    return YES;
}

- (BOOL)setNUIDisabledTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:value forState:UIControlStateDisabled];
    return YES;
}

- (BOOL)setNUILocalizedDisabledTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:NSLocalizedString(value, nil) forState:UIControlStateDisabled];
    return YES;
}

- (BOOL)setNUISelectedTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:value forState:UIControlStateSelected];
    return YES;
}

- (BOOL)setNUILocalizedSelectedTitle:(NSString *)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    [self setTitle:NSLocalizedString(value, nil) forState:UIControlStateSelected];
    return YES;
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

- (BOOL)loadNUIActionFromRValue:(NUIObject *)value loader:(NUILoader *)loader
{
    if (![value isKindOfClass:[NUIObject class]]) {
        return NO;
    }

    UIControlEvents event = UIControlEventTouchUpInside;
    NSString *strEvent = [value property:@"event" ofClass:[NSString class]];
    if (strEvent && ![self controlEvent:&event fromNUIValue:strEvent]) {
        return NO;
    }
    
    SEL selector = NSSelectorFromString([value property:@"selector" ofClass:[NSString class]]);

    id target = loader.rootObject;
    NUIIdentifier *targetId = [value property:@"target" ofClass:[NUIIdentifier class]];
    if (targetId) {
        target = [loader globalObjectForKey:targetId.value];
    }

    [self addTarget:target action:selector forControlEvents:event];
    return YES;
}

@end
