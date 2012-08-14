//
//  NUIStatement+BinaryOperator.m
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import "NUIStatement+BinaryOperator.h"

@implementation NUIStatement (BinaryOperator)

- (NUIStatement *)lvalue
{
    return [self.value objectAtIndex:0];
}

- (NUIStatement *)rvalue
{
    return [self.value objectAtIndex:1];
}

- (BOOL)isBinaryOperator
{
    return self.statementType > NUIStatementType_BinaryOperatorBegin &&
        self.statementType < NUIStatementType_BinaryOperatorEnd;
}

@end
