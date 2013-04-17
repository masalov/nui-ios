//
//  NUIGridLength.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUIGridLength.h"

@implementation NUIGridLength

@synthesize value = value_;
@synthesize type = type_;

- (id)initWithPixelValue:(CGFloat)value
{
    return [self initWithValue:value type:NUIGridLengthType_Pixel];
}

- (id)initWithValue:(CGFloat)value type:(NUIGridLengthType)type
{
    self = [super init];
    if (self) {
        value_ = value;
        type_ = type;
    }
    return self;
}

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        if ([string compare:@"auto" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            type_ = NUIGridLengthType_Auto;
        } else if ([string hasSuffix:@"*"]) {
            value_ = [string floatValue];
            type_ = NUIGridLengthType_Star;
        } else {
            value_ = [string floatValue];
            type_ = NUIGridLengthType_Pixel;
        }
    }
    return self;    
}

- (NSString *)description
{
    switch (type_) {
        case NUIGridLengthType_Auto:
            return [NSString stringWithFormat:@"type = auto"];
        case NUIGridLengthType_Pixel:
            return [NSString stringWithFormat:@"value = %f pixels", value_];
        default:
            return [NSString stringWithFormat:@"value = %f *", value_];
    }
}

@end
