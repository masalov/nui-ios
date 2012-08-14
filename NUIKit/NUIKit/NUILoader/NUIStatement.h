//
//  NUIStatement.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIData;

typedef enum NUIStatementType {
    NUIStatementType_String,
    NUIStatementType_Number,

    NUIStatementType_SimpleIdentifier,
    NUIStatementType_Identifier,
    NUIStatementType_SystemIdentifier,

    NUIStatementType_Object,
    NUIStatementType_ObjectSystemProperties,
    NUIStatementType_ObjectProperties,

    NUIStatementType_Array,
    
    // Just for determining if a statement is a binary operator.
    NUIStatementType_BinaryOperatorBegin,
    NUIStatementType_AssignmentOperator,
    NUIStatementType_ModificationOperator,
    NUIStatementType_BitwiseOrOperator,
    // Just for determining if a statement is a binary operator.
    NUIStatementType_BinaryOperatorEnd,
} NUIStatementType;

@interface NUIStatement : NSObject

@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) NUIStatementType statementType;
@property (nonatomic, retain) id value;
@property (nonatomic, retain) NUIData *data;

- (id)initWithData:(NUIData *)data type:(NUIStatementType)type;

@end
