//
//  NUIStatement+BinaryOperator.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUIStatement.h"

@interface NUIStatement (BinaryOperator)

- (NUIStatement *)lvalue;
- (NUIStatement *)rvalue;
- (BOOL)isBinaryOperator;

@end
