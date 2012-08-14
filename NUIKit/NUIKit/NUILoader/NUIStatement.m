//
//  NUIStatement.m
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIStatement.h"
#import "NUIData.h"

@implementation NUIStatement

@synthesize range = range_;
@synthesize statementType = statementType_;
@synthesize value = value_;
@synthesize data = data_;

- (id)initWithData:(NUIData *)data type:(NUIStatementType)type
{
    self = [super init];
    if (self) {
        self.data = data;
        statementType_ = type;
    }
    return self;
}

- (void)dealloc
{
    [value_ release];
    [data_ release];

    [super dealloc];
}

@end
