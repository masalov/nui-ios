//
//  NUIStatement+Object.m
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUIStatement+Object.h"
#import "NUIStatement+BinaryOperator.h"
#import "NUIError.h"

@implementation NUIStatement (Object)

- (NSMutableDictionary *)systemProperties
{
    return [(NUIStatement *)[self.value objectAtIndex:0] value];
}

- (NSMutableArray *)properties
{
    return [(NUIStatement *)[self.value objectAtIndex:1] value];
}

- (id)property:(NSString *)property ofClass:(Class)class error:(NUIError **)error
{
    for (NUIStatement *op in [self properties]) {
        if ([property isEqual:[op lvalue].value]) {
            if ([op.rvalue.value isKindOfClass:class]) {
                return op.rvalue.value;
            }
            *error = [NUIError errorWithStatement:op.lvalue message:[NSString stringWithFormat:
                @"Expecting %@ not %@.", NSStringFromClass(class),
                    NSStringFromClass([op.rvalue.value class])]];
            return nil;
        }
    }
    *error = [NUIError errorWithStatement:self message:[NSString stringWithFormat:
        @"Property %@ not found.", property]];
    return nil;
}

@end
