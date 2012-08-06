//
//  NUIObject.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIObject.h"
#import "NUIBinaryOperator.h"
#import "NUIIdentifier.h"


@implementation NUIObject

@synthesize type = type_;
@synthesize systemProperties = systemProperties_;
@synthesize properties = properties_;

- (id)init
{
    self = [super init];
    if (self) {
        systemProperties_ = [[NSMutableDictionary alloc] init];
        properties_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [type_ release];
    [systemProperties_ release];
    [properties_ release];

    [super dealloc];
}

- (id)property:(NSString *)property ofClass:(Class)class
{
    for (NUIBinaryOperator *op in properties_) {
        if ([property isEqual:((NUIIdentifier *)op.lvalue).value]) {
            if ([op.rvalue isKindOfClass:class]) {
                return op.rvalue;
            }
            NSAssert(NO, @"Error");
            return nil;
        }
    }
    return nil;
}

@end
