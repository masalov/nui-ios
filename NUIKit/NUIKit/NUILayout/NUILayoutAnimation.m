//
//  NUILayoutAnimation.m
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayoutAnimation.h"

@implementation NUILayoutAnimation

@synthesize duration = duration_;
@synthesize delay = delay_;
@synthesize curve = curve_;

- (id)init
{
    self = [super init];
    if (self) {
        duration_ = 0.2;
    }
    return self;
}

@end
