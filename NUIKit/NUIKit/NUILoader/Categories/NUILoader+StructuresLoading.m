//
//  NUILoader+StructuresLoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader+StructuresLoading.h"
#import "NUIStatement.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@implementation NUILoader (StructuresLoading)

- (BOOL)loadCGSizePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
{
    if (value.statementType != NUIStatementType_Array) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if ([value.value count] != 2) {
        NSAssert(NO, @"Invalid size format");
        return NO;
    }
    CGSize sz = CGSizeMake([[[value.value objectAtIndex:0] value] floatValue],
        [[[value.value objectAtIndex:1] value] floatValue]);
    objc_msgSend(object, setter, sz);
    return YES;
}

- (BOOL)loadCGRectPropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
{
    if (value.statementType != NUIStatementType_Array) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if ([value.value count] != 4) {
        NSAssert(NO, @"Invalid rect format");
        return NO;
    }
    CGRect rc = CGRectMake([[[value.value objectAtIndex:0] value] floatValue],
        [[[value.value objectAtIndex:1] value] floatValue],
        [[[value.value objectAtIndex:2] value] floatValue],
        [[[value.value objectAtIndex:3] value] floatValue]);
    objc_msgSend(object, setter, rc);
    return YES;
}

- (BOOL)loadNSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
{
    if (value.statementType != NUIStatementType_Array) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if ([value.value count] != 2) {
        NSAssert(NO, @"Invalid range format");
        return NO;
    }
    NSRange range = (NSRange){[[[value.value objectAtIndex:0] value] floatValue], [[[value.value objectAtIndex:1] value] floatValue]};
    objc_msgSend(object, setter, range);
    return YES;
}

- (BOOL)load_NSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value;
{
    return [self loadNSRangePropertyOfObject:object setter:setter value:value];
}

- (BOOL)loadUIEdgeInsetsPropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
{
    if (value.statementType != NUIStatementType_Array) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if ([value.value count] != 4) {
        NSAssert(NO, @"Invalid edge insets format");
        return NO;
    }
    UIEdgeInsets insets = UIEdgeInsetsMake([[[value.value objectAtIndex:0] value] floatValue],
        [[[value.value objectAtIndex:1] value] floatValue],
        [[[value.value objectAtIndex:2] value] floatValue],
        [[[value.value objectAtIndex:3] value] floatValue]);
    objc_msgSend(object, setter, insets);
    return YES;
}

- (BOOL)loadCGAffineTransformPropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
{
    if (value.statementType != NUIStatementType_Array) {
        NSAssert(NO, @"Should be array");
        return NO;
    }
    if ([value.value count] != 6) {
        NSAssert(NO, @"Invalid affine transform format");
        return NO;
    }
    CGAffineTransform transform =
        CGAffineTransformMake([[[value.value objectAtIndex:0] value] floatValue],
        [[[value.value objectAtIndex:1] value] floatValue],
        [[[value.value objectAtIndex:2] value] floatValue],
        [[[value.value objectAtIndex:3] value] floatValue],
        [[[value.value objectAtIndex:4] value] floatValue],
        [[[value.value objectAtIndex:5] value] floatValue]);
    objc_msgSend(object, setter, transform);
    return YES;
}

@end