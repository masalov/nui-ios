//
//  NUILayoutConfig.m
//  NUIKit
//
//  Created by Ivan Masalov on 08/12/13.
//  Copyright (c) 2013 Noveo Group. All rights reserved.
//

#import "NUILayoutConfig.h"

#import <math.h>

float nuiRoudningScale = 1.f;

float scaled_floorf(float value)
{
    return floorf(value * nuiRoudningScale) / nuiRoudningScale;
}
