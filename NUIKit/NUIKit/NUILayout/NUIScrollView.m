//
//  NUIScrollView.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUIScrollView.h"
#import "NUILayoutItem.h"
#import "UIView+NUILayout.h"

@implementation NUIScrollView

@synthesize horizontalScrollerEnabled = horizontalScrollerEnabled_;
@synthesize verticalScrollerEnabled = verticalScrollerEnabled_;
@synthesize contentView = contentView_;
@synthesize contentLayoutItem = contentLayoutItem_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        verticalScrollerEnabled_ = YES;
        contentLayoutItem_ = [[NUILayoutItem alloc] init];
        contentLayoutItem_.verticalAlignment = NUIVerticalAlignment_Top;
    }
    return self;
}

- (void)dealloc
{
    [contentView_ removeObserver:self forKeyPath:@"needsToUpdateSize"];
}

- (void)setHorizontalScrollerEnabled:(BOOL)horizontalScrollerEnabled
{
    if (horizontalScrollerEnabled_ != horizontalScrollerEnabled) {
        horizontalScrollerEnabled_ = horizontalScrollerEnabled;
        [self setNeedsLayout];
    }
}

- (void)setVerticalScrollerEnabled:(BOOL)verticalScrollerEnabled
{
    if (verticalScrollerEnabled_ != verticalScrollerEnabled) {
        verticalScrollerEnabled_ = verticalScrollerEnabled;
        [self setNeedsLayout];
    }
}

- (void)setContentView:(UIView *)contentView
{
    if (contentView_ == contentView) {
        return;
    }
    if (contentView_) {
        [contentView_ removeFromSuperview];
        [contentView_ removeObserver:self forKeyPath:@"needsToUpdateSize"];
    }
    contentView_ = contentView;
    [contentView_ addObserver:self
                   forKeyPath:@"needsToUpdateSize"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    [self addSubview:contentView_];
    contentLayoutItem_.view = contentView;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize constraintSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    if (!horizontalScrollerEnabled_) {
        constraintSize.width = self.bounds.size.width;
    }
    if (!verticalScrollerEnabled_) {
        constraintSize.height = self.bounds.size.height;
    }
    CGSize maxSize = self.bounds.size;
    CGSize size = [contentLayoutItem_ sizeWithMarginThatFits:constraintSize];
    if (maxSize.width < size.width) {
        maxSize.width = size.width;
    }
    if (maxSize.height < size.height) {
        maxSize.height = size.height;
    }
    self.contentSize = maxSize;
    
    [contentLayoutItem_ placeInRect:CGRectMake(0, 0, maxSize.width, maxSize.height)
                      preferredSize:size];
}

#pragma mark - observers

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"needsToUpdateSize"]) {
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        if (newValue != [NSNull null] && [newValue boolValue]) {
            [self setNeedsLayout];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    return [contentView_ preferredSizeThatFits:size];
}

@end
