//
//  UIColor+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 8/17/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIColor+NUILoading.h"
#import "NUILoader.h"
#import "NUIStatement.h"
#import "NUIStatement+Object.h"
#import "NUIError.h"

@implementation UIColor (NUILoading)

+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error
{
    NSString *value = [nuiObject property:@"color" ofClass:[NSString class] error:error];
    if (value) {
        if (value.length != 6 && value.length != 8) {
            *error = [NUIError errorWithStatement:nuiObject message:@"Expecting 6 or 8 symbols."];
            return NO;
        }
        id pool = [[NSAutoreleasePool alloc] init];
        NSString *stringColor = [NSString stringWithFormat:@"%@%@", value,
                ((value.length == 6) ? @"FF" : [NSString string])];
        NSScanner *scanner = [NSScanner scannerWithString:stringColor];

        unsigned intColor;
        if (![scanner scanHexInt:&intColor]) {
            intColor = 0;
        }
        [pool release];
        return [UIColor colorWithRed:(CGFloat)((intColor & 0xFF000000) >> 24) / 255.f
            green:(CGFloat)((intColor & 0x00FF0000) >> 16) / 255.f
            blue:(CGFloat)((intColor & 0x0000FF00) >> 8) / 255.f
            alpha:(CGFloat)(intColor & 0x000000FF) / 255.f];
    }
    value = [nuiObject property:@"patternImage" ofClass:[NSString class] error:error];
    if (value) {
        return [UIColor colorWithPatternImage:[UIImage imageNamed:value]];
    }
    NSNumber *red = [nuiObject property:@"red" ofClass:[NSNumber class] error:error];
    NSNumber *green = [nuiObject property:@"green" ofClass:[NSNumber class] error:error];
    NSNumber *blue = [nuiObject property:@"blue" ofClass:[NSNumber class] error:error];
    if (!red || !green || !blue) {
        *error = [NUIError errorWithStatement:nuiObject message:
            @"Expecting color property or red, green, blue and alpha properies."];
    }
    NSNumber *alpha = [nuiObject property:@"alpha" ofClass:[NSNumber class] error:error];
    if (!alpha) {
        return [UIColor colorWithRed:[red intValue] / 255.f green:[green intValue] / 255.f
            blue:[blue intValue] / 255.f alpha:1.f];
    }
    return [UIColor colorWithRed:[red intValue] / 255.f green:[green intValue] / 255.f
        blue:[blue intValue] / 255.f alpha:[alpha intValue] / 255.f];
}
@end