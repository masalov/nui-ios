//
//  NUIError.m
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import "NUIError.h"
#import "NUIData.h"

@implementation NUIError

@synthesize data = data_;
@synthesize position = position_;
@synthesize message = message_;

- (id)initWithData:(NUIData *)data position:(int)position message:(NSString *)message
{
    self = [super init];
    if (self) {
        self.data = data;
        self.position = position;
        self.message = message;
    }
    return self;
}

- (void)dealloc
{
    [data_ release];
    [message_ release];

    [super dealloc];
}

+ (id)errorWithData:(NUIData *)data position:(int)position message:(NSString *)message
{
    return [[[NUIError alloc] initWithData:data position:position message:message] autorelease];
}

@end
