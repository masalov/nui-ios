//
//  nui_utils.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "nui_utils.h"
#include <objc/runtime.h>

NSString *propertyClassName(Class cl, NSString *propertyName)
{
    objc_property_t property
    = class_getProperty(cl, [propertyName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (!property) {
        return nil;
    }
    // Check if property attributes starts with T@"<class name>"
    const char *attributes = property_getAttributes(property);
    if (strncmp(attributes, "T@\"", 3)) {
        return nil;
    }
    int len = strlen(attributes);
    for (int i = 3; i < len; ++i) {
        if (attributes[i] == '\"') {
            return [[[NSString alloc] initWithBytes:attributes + 3
                                             length:i - 3
                                           encoding:NSASCIIStringEncoding]
                    autorelease];
        }
    }
    return nil;
}

BOOL isSuperClass(Class cl, Class superCl)
{
    while (YES) {
        if (cl == superCl) {
            return YES;
        }
        if (cl == nil) {
            return NO;
        }
        cl = class_getSuperclass(cl);
    }
}
