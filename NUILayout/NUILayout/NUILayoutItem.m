//
//  NUILayoutItem.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayoutItem.h"
#import "UIView+NUILayout.h"

@implementation NUILayoutItem

@synthesize view = view_;
@synthesize margin = margin_;
@synthesize verticalAlignment = verticalAlignment_;
@synthesize horizontalAlignment = horizontalAlignment_;

@synthesize minWidth = minWidth_;
@synthesize maxWidth = maxWidth_;

@synthesize minHeight = minHeight_;
@synthesize maxHeight = maxHeight_;

@synthesize fixedWidth = fixedWidth_;
@synthesize isFixedWidthSet = isFixedWidthSet_;

@synthesize fixedHeight = fixedHeight_;
@synthesize isFixedHeightSet = isFixedHeightSet_;

@synthesize visibility = visibility_;

- (id)init
{
    self = [super init];
    if (self) {
        maxWidth_ = CGFLOAT_MAX;
        maxHeight_ = CGFLOAT_MAX;
    }
    return self;
}

- (void)dealloc
{
    [view_ release];
    [super dealloc];
}

- (void)setMargin:(UIEdgeInsets)margin
{
    margin_ = margin;
    view_.needsToUpdateSize = YES;
}

- (void)setVerticalAlignment:(NUIVerticalAlignment)verticalAlignment
{
    verticalAlignment_ = verticalAlignment;
    view_.needsToUpdateSize = YES;
}

- (void)setHorizontalAlignment:(NUIHorizontalAlignment)horizontalAlignment
{
    horizontalAlignment_ = horizontalAlignment;
    view_.needsToUpdateSize = YES;
}

- (void)setMinSize:(CGSize)minSize
{
    self.minWidth = minSize.width;
    self.minHeight = minSize.height;
}

- (CGSize)minSize
{
    return CGSizeMake(self.minWidth, self.minHeight);
}

- (void)setMaxSize:(CGSize)maxSize
{
    self.maxWidth = maxSize.width;
    self.maxHeight = maxSize.height;
}

- (CGSize)maxSize
{
    return CGSizeMake(self.maxWidth, self.maxHeight);
}

- (void)setFixedSize:(CGSize)fixedSize
{
    self.fixedWidth = fixedSize.width;
    self.fixedHeight = fixedSize.height;
}

- (CGSize)fixedSize
{
    return CGSizeMake(self.fixedWidth, self.fixedHeight);
}

#pragma mark - width

- (void)setMinWidth:(CGFloat)minWidth
{
    minWidth_ = minWidth;
    view_.needsToUpdateSize = YES;
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    maxWidth_ = maxWidth;
    view_.needsToUpdateSize = YES;
}

- (void)setFixedWidth:(CGFloat)fixedWidth
{
    fixedWidth_ = fixedWidth;
    self.isFixedWidthSet = YES;
}

- (void)setIsFixedWidthSet:(BOOL)isFixedWidthSet
{
    isFixedWidthSet_ = isFixedWidthSet;
    view_.needsToUpdateSize = YES;
}

#pragma mark - height

- (void)setMinHeight:(CGFloat)minHeight
{
    minHeight_ = minHeight;
    view_.needsToUpdateSize = YES;
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
    maxHeight_ = maxHeight;
    view_.needsToUpdateSize = YES;
}

- (void)setFixedHeight:(CGFloat)fixedHeight
{
    fixedHeight_ = fixedHeight;
    self.isFixedHeightSet = YES;
    view_.needsToUpdateSize = YES;
}

- (void)setIsFixedHeightSet:(BOOL)isFixedHeightSet
{
    isFixedHeightSet_ = isFixedHeightSet;
    view_.needsToUpdateSize = YES;
}

- (void)setVisibility:(NUIVisibility)visibility
{
    visibility_ = visibility;
    view_.hidden = visibility_ != NUIVisibility_Visible;
    view_.needsToUpdateSize = YES;
}

- (CGFloat)constraintWidth:(CGFloat)width
{
    if (self.isFixedWidthSet) {
        width = self.fixedWidth;
    } else if (width < self.minWidth) {
        width = self.minWidth;
    } else if (width > self.maxWidth) {
        width = self.maxWidth;
    }
    return width;
}

- (CGFloat)constraintHeight:(CGFloat)height
{
    if (self.isFixedHeightSet) {
        height = self.fixedHeight;
    } else if (height < self.minHeight) {
        height = self.minHeight;
    } else if (height > self.maxHeight) {
        height = self.maxHeight;
    }
    return height;
}

- (CGSize)constraintSize:(CGSize)size
{
    size.width = [self constraintWidth:size.width];
    size.height = [self constraintHeight:size.height];
    return size;
}

- (CGSize)sizeWithMarginThatFits:(CGSize)size
{
    if (visibility_ == NUIVisibility_Collapsed) {
        return CGSizeZero;
    }
    UIEdgeInsets margin = self.margin;
    
    if (self.isFixedWidthSet && self.isFixedHeightSet) {
        return CGSizeMake(self.fixedWidth + margin.left + margin.right,
                          self.fixedHeight + margin.top + margin.bottom);
    }
    size.width -= margin.left + margin.right;
    size.height -= margin.top + margin.bottom;

    size = [self constraintSize:size];
    size = [self constraintSize:[view_ preferredSizeThatFits:size]];
    if (size.width != CGFLOAT_MAX) {
        size.width += margin.left + margin.right;
    }
    if (size.height != CGFLOAT_MAX) {
        size.height += margin.top + margin.bottom;
    }
    return size;
}

- (void)placeInRect:(CGRect)rect preferredSize:(CGSize)size
{
    rect = UIEdgeInsetsInsetRect(rect, margin_);
    if (visibility_ == NUIVisibility_Collapsed) {
        view_.frame = rect;
        return;
    }
    size.width -= margin_.left + margin_.right;
    size.height -= margin_.top + margin_.bottom;
    
    if (self.horizontalAlignment == NUIHorizontalAlignment_Stretch) {
        size.width = [self constraintWidth:rect.size.width];
    }
    if (self.verticalAlignment == NUIVerticalAlignment_Stretch) {
        size.height = [self constraintHeight:rect.size.height];
    }
    CGFloat x = 0;
    switch (self.horizontalAlignment) {
        case NUIHorizontalAlignment_Left:
            x = rect.origin.x;
            break;
        case NUIHorizontalAlignment_Right:
            x = rect.origin.x + rect.size.width - size.width;
            break;
        case NUIHorizontalAlignment_Stretch:
            size.width = [self constraintWidth:rect.size.width];
        default:
            x = floorf(rect.origin.x + (rect.size.width - size.width) / 2);
            break;
    }
    CGFloat y = 0;
    switch (self.verticalAlignment) {
        case NUIVerticalAlignment_Top:
            y = rect.origin.y;
            break;
        case NUIVerticalAlignment_Bottom:
            y = rect.origin.y + rect.size.height - size.height;
            break;
        case NUIVerticalAlignment_Stretch:
            size.height = [self constraintHeight:rect.size.height];
        default:
            y = floorf(rect.origin.y + (rect.size.height - size.height) / 2);
            break;
    }
    view_.frame = CGRectMake(x, y, size.width, size.height);
}

@end
