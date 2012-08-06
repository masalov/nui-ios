//
//  NUILoader+ObjectsLoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader+ObjectsLoading.h"
#import <UIKit/UIKit.h>

@implementation NUILoader (ObjectsLoading)

- (BOOL)loadUIColorPropertyOfObject:(id)object property:(NSString *)property value:(id)rvalue
{
    if ([rvalue isKindOfClass:[NSString class]]) {
        NSString *value = (NSString *)rvalue;
        if (value.length != 6 && value.length != 8) {
            NSAssert(NO, @"Invalid color format");
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
        [object setValue:[UIColor colorWithRed:(CGFloat)((intColor & 0xFF000000) >> 24) / 255.f
            green:(CGFloat)((intColor & 0x00FF0000) >> 16) / 255.f
            blue:(CGFloat)((intColor & 0x0000FF00) >> 8) / 255.f
            alpha:(CGFloat)(intColor & 0x000000FF) / 255.f]
            forKey:property];
        return YES;
    }
    if ([rvalue isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)rvalue;
        if (array.count == 3) {
            [object setValue:[UIColor colorWithRed:[[array objectAtIndex:0] floatValue] / 255.0f
                green:[[array objectAtIndex:1] floatValue] / 255.0f
                blue:[[array objectAtIndex:2] floatValue] / 255.0f
                alpha:1.0f]
                forKey:property];
        } else if (array.count == 4) {
            [object setValue:[UIColor colorWithRed:[[array objectAtIndex:0] floatValue] / 255.0f
                green:[[array objectAtIndex:1] floatValue] / 255.0f
                blue:[[array objectAtIndex:2] floatValue] / 255.0f
                alpha:[[array objectAtIndex:3] floatValue] / 255.0f]
                forKey:property];
        } else {
            NSAssert(NO, @"Invalid color format");
            return NO;
        }
    }
    return YES;
}

@end