//
//  NUILayoutAnimation.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! A class for specifing animation paraemters during layouting. */
@interface NUILayoutAnimation : NSObject

/*! Default value is 0.2. */
@property (nonatomic, assign) NSTimeInterval duration;
/*! Default value is 0.0. */
@property (nonatomic, assign) NSTimeInterval delay;
/*! Default value is \b UIViewAnimationCurveEaseInOut. */
@property (nonatomic, assign) UIViewAnimationCurve curve;

@end
