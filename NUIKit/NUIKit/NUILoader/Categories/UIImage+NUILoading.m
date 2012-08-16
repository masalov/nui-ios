//
//  UIImage+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIImage+NUILoading.h"
#import "NUILoader.h"
#import "NUIStatement+Object.h"
#import "NUIError.h"

@implementation UIImage (NUILoading)

+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error
{
    NSString *path = [nuiObject property:@"file" ofClass:[NSString class] error:error];
    if (!path) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:path];
    if (!image) {
        *error = [NUIError errorWithData:nuiObject.data position:nuiObject.range.location
            message:[NSString stringWithFormat:@"Failed to load image from file: \"%@\".", path]];
        return nil;
    }
    NSInteger leftCapWidth = [[nuiObject property:@"leftCapWidth" ofClass:[NSNumber class]
        error:error] integerValue];
    NSInteger topCapHeight = [[nuiObject property:@"topCapHeight" ofClass:[NSNumber class]
        error:error] integerValue];
    if (leftCapWidth != 0 || topCapHeight != 0) {
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    }
    return image;
}

@end
