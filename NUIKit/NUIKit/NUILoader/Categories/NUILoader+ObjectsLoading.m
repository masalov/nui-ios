//
//  NUILoader+ObjectsLoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader+ObjectsLoading.h"
#import "NUIStatement.h"
#import "NUIError.h"
#import "UIColor+NUILoading.h"

@implementation NUILoader (ObjectsLoading)

- (BOOL)loadUIColorPropertyOfObject:(id)object property:(NSString *)property
    value:(NUIStatement *)rvalue error:(NUIError **)error
{
    if (rvalue.statementType == NUIStatementType_String) {
        NSString *value = rvalue.value;
        if (value.length != 6 && value.length != 8) {
            *error = [NUIError errorWithStatement:rvalue message:@"Expecting 6 or 8 symbols."];
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
    if (rvalue.statementType == NUIStatementType_Array) {
        NSArray *array = [self calculateArrayOfNumericExpressions:rvalue containingObject:object];
        if (!array) {
            *error = self.lastError;
            return NO;
        }
        if (array.count == 3) {
            [object setValue:[UIColor colorWithRed:[[array objectAtIndex:0] floatValue] / 255.0f
                green:[[array objectAtIndex:1] floatValue] / 255.0f
                blue:[[array objectAtIndex:2] floatValue] / 255.0f
                alpha:1.0f]
                forKey:property];
            return YES;
        } else if (array.count == 4) {
            [object setValue:[UIColor colorWithRed:[[array objectAtIndex:0] floatValue] / 255.0f
                green:[[array objectAtIndex:1] floatValue] / 255.0f
                blue:[[array objectAtIndex:2] floatValue] / 255.0f
                alpha:[[array objectAtIndex:3] floatValue] / 255.0f]
                forKey:property];
            return YES;
        }
        *error = [NUIError errorWithStatement:rvalue message:@"Expecting 6 or 8 numbers."];
        return NO;
    }
    id color = [UIColor loadFromNUIObject:rvalue loader:self error:error];
    if (color) {
        [object setValue:color forKey:property];
        return YES;
    }
    return NO;
}

@end