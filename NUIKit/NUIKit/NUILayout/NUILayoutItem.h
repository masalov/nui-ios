//
//  NUILayoutItem.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NUIView;
@class NUILayout;

typedef enum {
    NUIVerticalAlignment_Center,
    NUIVerticalAlignment_Top,
    NUIVerticalAlignment_Bottom,
    NUIVerticalAlignment_Stretch,
} NUIVerticalAlignment;

typedef enum {
    NUIHorizontalAlignment_Center,
    NUIHorizontalAlignment_Left,
    NUIHorizontalAlignment_Right,
    NUIHorizontalAlignment_Stretch,
} NUIHorizontalAlignment;

typedef enum {
    NUIVisibility_Visible,
    NUIVisibility_Hidden,
    NUIVisibility_Collapsed,
} NUIVisibility;

// Base class for layout item.
// Layout item defines layouting attributes of corresponding view.
@interface NUILayoutItem : NSObject

@property (nonatomic, assign) NUILayout *layout;
@property (nonatomic, retain) id<NUIView> view;

@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) NUIVerticalAlignment verticalAlignment;
@property (nonatomic, assign) NUIHorizontalAlignment horizontalAlignment;

@property (nonatomic, assign) CGSize minSize;
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, assign) CGSize fixedSize;

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) CGFloat fixedWidth;
@property (nonatomic, assign) BOOL isFixedWidthSet;

@property (nonatomic, assign) CGFloat fixedHeight;
@property (nonatomic, assign) BOOL isFixedHeightSet;

// Use it instead of view hidden property
@property (nonatomic, assign) NUIVisibility visibility;

// Constraining by min and max sizes
- (CGFloat)constraintWidth:(CGFloat)width;
- (CGFloat)constraintHeight:(CGFloat)height;
- (CGSize)constraintSize:(CGSize)size;

- (CGSize)sizeWithMarginThatFits:(CGSize)size;

// Set view frame taking in respect view alignment
- (void)placeInRect:(CGRect)rect preferredSize:(CGSize)size;

@end
