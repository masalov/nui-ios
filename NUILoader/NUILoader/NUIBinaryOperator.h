//
//  NUIBinaryOperator.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NUIBinaryOperatorType_Invalid = 0,
    NUIBinaryOperatorType_Assignment,
    NUIBinaryOperatorType_Modification,
    NUIBinaryOperatorType_BitwiseOr,
} NUIBinaryOperatorType;

@interface NUIBinaryOperator : NSObject

@property (nonatomic, assign) NUIBinaryOperatorType type;
@property (nonatomic, retain) id lvalue;
@property (nonatomic, retain) id rvalue;

@end