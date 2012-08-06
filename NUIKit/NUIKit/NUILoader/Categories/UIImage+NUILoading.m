//
//  UIImage+NUILoading.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "UIImage+NUILoading.h"
#import "NUILoader.h"
#import "NUIObject.h"

@implementation UIImage (NUILoading)

+ (id)loadFromNUIObject:(NUIObject *)nuiObject loader:(NUILoader *)loader
{
    NSString *path = [nuiObject property:@"file" ofClass:[NSString class]];
    UIImage *image = [UIImage imageNamed:path];
    if (!image) {
        NSAssert(NO, @"Failed to load image from file: %@", path);
        return nil;
    }
    CGFloat leftCapWidth = [[nuiObject property:@"leftCapWidth" ofClass:[NSNumber class]]
        floatValue];
    CGFloat topCapHeight = [[nuiObject property:@"topCapHeight" ofClass:[NSNumber class]]
        floatValue];
    if (leftCapWidth != 0 || topCapHeight != 0) {
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    }
    return image;
}

@end
