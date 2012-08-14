//
//  NUIStatement+Object.m
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import "NUIStatement+Object.h"
#import "NUIStatement+BinaryOperator.h"

@implementation NUIStatement (Object)

- (NSMutableDictionary *)systemProperties
{
    return [(NUIStatement *)[self.value objectAtIndex:0] value];
}

- (NSMutableArray *)properties
{
    return [(NUIStatement *)[self.value objectAtIndex:1] value];
}

- (id)property:(NSString *)property ofClass:(Class)class
{
    for (NUIStatement *op in [self properties]) {
        if ([property isEqual:[op lvalue].value]) {
            if ([op.rvalue.value isKindOfClass:class]) {
                return op.rvalue.value;
            }
            NSAssert(NO, @"Error");
            return nil;
        }
    }
    return nil;
}

@end
