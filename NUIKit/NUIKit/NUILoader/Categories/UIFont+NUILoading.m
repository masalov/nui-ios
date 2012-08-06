//
//  UIFont+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIFont+NUILoading.h"
#import "NUILoader.h"
#import "NUIObject.h"

@implementation UIFont (NUILoading)

+ (id)loadFromNUIObject:(NUIObject *)nuiObject loader:(NUILoader *)loader
{
    NSNumber *size = [nuiObject property:@"size" ofClass:[NSNumber class]];
    if (!size) {
        NSAssert(NO, @"Font must have size attribute");
        return nil;
    }
    id object = nil;
    NSString *name = [nuiObject property:@"name" ofClass:[NSString class]];
    if (name) {
        object = [UIFont fontWithName:name size:[size floatValue]];
    } else {
        NSString *type = [nuiObject property:@"type" ofClass:[NSString class]];
        if (!type || [type compare:@"normal" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            object = [UIFont systemFontOfSize:[size floatValue]];
        } else  if ([type compare:@"italic" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            object = [UIFont italicSystemFontOfSize:[size floatValue]];
        } else if ([type compare:@"bold" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            object = [UIFont boldSystemFontOfSize:[size floatValue]];
        } else {
            NSAssert(NO, @"Unknown font type %@", type);
        }
    }
    NSAssert(object, @"Failed to load font.");
    return object;
}

@end
