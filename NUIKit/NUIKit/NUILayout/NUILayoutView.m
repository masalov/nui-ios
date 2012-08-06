//
//  NUILayoutView.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayoutView.h"
#import "NUILayout.h"
#import "UIView+NUILayout.h"
#import "NUILayoutAnimation.h"

@interface NUILayoutView ()
{
    BOOL firstLayouting_;
    BOOL deallocating_;
}

@end

@implementation NUILayoutView

@synthesize layout = layout_;
@synthesize layoutAnimation = layoutAnimation_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        firstLayouting_ = YES;
        self.autoresizesSubviews = NO;
    }
    return self;
}

- (void)dealloc
{
    deallocating_ = YES;
    for (UIView *subview in self.subviews) {
        [subview removeObserver:self forKeyPath:@"needsToUpdateSize"];
    }
    [layout_ release];
    [layoutAnimation_ release];
    [super dealloc];
}

- (void)setLayout:(NUILayout *)layout
{
    if (layout == layout_) {
        return;
    }
    layout.view = self;
    [layout retain];

    layout_.view = nil;
    for (UIView *subview in [layout_ subviews]) {
        [subview removeFromSuperview];
    }
    [layout_ release];
    layout_ = layout;
    for (UIView *subview in [layout_ subviews]) {
        [self addSubview:subview];
    }
}

- (void)layoutSubviews
{
    if (!firstLayouting_ && layoutAnimation_) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:layoutAnimation_.duration];
        [UIView setAnimationDelay:layoutAnimation_.delay];
        [UIView setAnimationCurve:layoutAnimation_.curve];
    }
    [layout_ layoutForSize:self.bounds.size];
    if (!firstLayouting_ && layoutAnimation_) {
        [UIView commitAnimations];
    }
    firstLayouting_ = NO;
}

- (CGSize)preferredSizeThatFits:(CGSize)size
{
    if (!layout_) {
        return CGSizeZero;
    }
    return [layout_ preferredSizeThatFits:size];
}

#pragma mark - observers

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];

    [subview addObserver:self
              forKeyPath:@"needsToUpdateSize"
                 options:NSKeyValueObservingOptionNew
                 context:NULL];
    self.needsToUpdateSize = YES;
    [self setNeedsLayout];
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];

    if (!deallocating_) {
        [subview removeObserver:self forKeyPath:@"needsToUpdateSize"];
        self.needsToUpdateSize = YES;
        [self setNeedsLayout];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"needsToUpdateSize"]) {
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        if (newValue != [NSNull null] && [newValue boolValue]) {
            self.needsToUpdateSize = YES;
            [self setNeedsLayout];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
