//
//  UIFont+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIFont+NUILoading.h"
#import "NUILoader.h"
#import "NUIStatement+Object.h"
#import "NUIError.h"

@implementation UIFont (NUILoading)

+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error
{
    NSNumber *size = [nuiObject property:@"size" ofClass:[NSNumber class]];
    if (!size) {
        *error = [NUIError errorWithData:nuiObject.data position:nuiObject.range.location
            message:@"Expecting size property."];
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
            *error = [NUIError errorWithData:nuiObject.data position:nuiObject.range.location
                message:[NSString stringWithFormat:@"Unknown font type %@.", type]];
            return nil;
        }
    }
    if (!object) {
        *error = [NUIError errorWithData:nuiObject.data position:nuiObject.range.location
            message:@"Failed to create font."];
    }
    return object;
}

@end
