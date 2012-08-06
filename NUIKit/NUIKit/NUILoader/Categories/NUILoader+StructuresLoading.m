//
//  NUILoader+StructuresLoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader+StructuresLoading.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@implementation NUILoader (StructuresLoading)

- (BOOL)loadCGSizePropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if (value.count != 2) {
        NSAssert(NO, @"Invalid size format");
        return NO;
    }
    CGSize sz = CGSizeMake([[value objectAtIndex:0] floatValue],
        [[value objectAtIndex:1] floatValue]);
    objc_msgSend(object, setter, sz);
    return YES;
}

- (BOOL)loadCGRectPropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if (value.count != 4) {
        NSAssert(NO, @"Invalid rect format");
        return NO;
    }
    CGRect rc = CGRectMake([[value objectAtIndex:0] floatValue],
        [[value objectAtIndex:1] floatValue],
        [[value objectAtIndex:2] floatValue],
        [[value objectAtIndex:3] floatValue]);
    objc_msgSend(object, setter, rc);
    return YES;
}

- (BOOL)loadNSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if (value.count != 2) {
        NSAssert(NO, @"Invalid range format");
        return NO;
    }
    NSRange range = (NSRange){[[value objectAtIndex:0] floatValue], [[value objectAtIndex:1] floatValue]};
    objc_msgSend(object, setter, range);
    return YES;
}

- (BOOL)loadUIEdgeInsetsPropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if (value.count != 4) {
        NSAssert(NO, @"Invalid edge insets format");
        return NO;
    }
    UIEdgeInsets insets = UIEdgeInsetsMake([[value objectAtIndex:0] floatValue],
        [[value objectAtIndex:1] floatValue],
        [[value objectAtIndex:2] floatValue],
        [[value objectAtIndex:3] floatValue]);
    objc_msgSend(object, setter, insets);
    return YES;
}

- (BOOL)loadCGAffineTransformPropertyOfObject:(id)object
    setter:(SEL)setter
    value:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if (value.count != 6) {
        NSAssert(NO, @"Invalid affine transform format");
        return NO;
    }
    CGAffineTransform transform =
        CGAffineTransformMake([[value objectAtIndex:0] floatValue],
        [[value objectAtIndex:1] floatValue],
        [[value objectAtIndex:2] floatValue],
        [[value objectAtIndex:3] floatValue],
        [[value objectAtIndex:4] floatValue],
        [[value objectAtIndex:5] floatValue]);
    objc_msgSend(object, setter, transform);
    return YES;
}

@end