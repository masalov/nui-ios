//
//  NUIIdentifier.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIIdentifier.h"


@implementation NUIIdentifier

@synthesize value = value_;

- (void)dealloc
{
    [value_ release];
    [super dealloc];
}

@end
