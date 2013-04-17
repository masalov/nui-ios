//
//  NUIGridLayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import "NUILayout.h"

@class NUIGridLayoutItem;

typedef enum {
    NUIGridLayoutInsertionMethod_None,
    NUIGridLayoutInsertionMethod_LeftRightTopDown,
    NUIGridLayoutInsertionMethod_TopDownLeftRight
} NUIGridLayoutInsertionMethod;

/*! Layouts subviews in a grid. A subview can take several columns and rows. If there are not enough
 *  columns or rows they are added automatically with \b NUIGridLengthType_Auto type.
 */
@interface NUIGridLayout : NUILayout

/*! An array of \b NUIGridLength. */
@property (nonatomic, copy) NSArray *columns;
/*! An array of \b NUIGridLength. */
@property (nonatomic, copy) NSArray *rows;
/*! Setting this property allows to place subviews one after another without specifying columns and
 *  rows explicitly.
 */
@property (nonatomic, unsafe_unretained) NUIGridLayoutInsertionMethod insertionMethod;

/*! Allows to simplify setting of columns and rows. \b columns and \b rows are arrays of strings
 *  that used to create \b NUIGridLength with \b initWithString: method. */
- (id)initWithColumns:(NSArray *)columns rows:(NSArray *)rows;
/*! Allows to simplify setting of columns and rows. \b columns and \b rows are arrays of strings
 *  that used to create \b NUIGridLength with \b initWithString: method. */
- (void)setColumns:(NSArray *)columns rows:(NSArray *)rows;

/*! Places \b view in a 1x1 cell according to \b insertionMethod. */
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view;
/*! Places \b view in a 1x1 cell. */
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view column:(NSUInteger)column row:(NSUInteger)row;
/*! Places \b view in a specified cell. */
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view columnRange:(NSRange)columnRange
    rowRange:(NSRange)rowRange;
/*! Places \b view in a cell of \b columns x \b rows size according to \b insertionMethod. */
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view columns:(NSUInteger)columns
    rows:(NSUInteger)rows;
/*! Removes \b view from layout. */
- (void)removeSubview:(id<NUIView>)view;

/*! Number of columns including added automatically. */
- (NSUInteger)columnsCount;
/*! Number of rows including added automatically. */
- (NSUInteger)rowsCount;

@end
