//
//  NUIGridLength.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NUIGridLengthType_Auto = 0,
    NUIGridLengthType_Pixel,
    NUIGridLengthType_Star,
} NUIGridLengthType;

@interface NUIGridLength : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) NUIGridLengthType type;

- (id)initWithPixelValue:(CGFloat)value;
- (id)initWithValue:(CGFloat)value type:(NUIGridLengthType)type;
// Possible values: auto, 11.5, 45*, ...
- (id)initWithString:(NSString *)string;

@end