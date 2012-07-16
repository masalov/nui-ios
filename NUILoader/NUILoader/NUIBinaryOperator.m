//
//  NUIBinaryOperator.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIBinaryOperator.h"


@implementation NUIBinaryOperator

@synthesize lvalue = lvalue_;
@synthesize rvalue = rvalue_;
@synthesize type = type_;


- (void)dealloc
{
    [lvalue_ release];
    [rvalue_ release];

    [super dealloc];
}

@end