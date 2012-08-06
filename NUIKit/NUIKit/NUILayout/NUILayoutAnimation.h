//
//  NUILayoutAnimation.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NUILayoutAnimation : NSObject

// default = 0.2
@property (nonatomic, assign) NSTimeInterval duration;
// default = 0.0
@property (nonatomic, assign) NSTimeInterval delay;
// default = UIViewAnimationCurveEaseInOut
@property (nonatomic, assign) UIViewAnimationCurve curve;

@end
