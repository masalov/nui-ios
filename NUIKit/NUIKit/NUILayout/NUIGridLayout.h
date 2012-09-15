//
//  NUIGridLayout.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayout.h"

@class NUIGridLayoutItem;

typedef enum {
    NUIGridLayoutInsertionMethod_None,
    NUIGridLayoutInsertionMethod_LeftRightTopDown,
    NUIGridLayoutInsertionMethod_TopDownLeftRight
} NUIGridLayoutInsertionMethod;

// Layout subviews in grid. Use UIView (GridLayout) properties for settings rows range and column range
// Use UIView (CommonLayoutProperties) properties for setting minimum size, padding and alignment of view
// Minimum size of each row is maximum of minHeight of row and minSize.height of views in this row.
// Minimum size of each column is maximum of minWidth of column and minSize.width of views in this column.
// If view takes two or more columns/rows than they are resized according to stretch factor
// or uniformly if sum of stretch factors is too small.

@interface NUIGridLayout : NUILayout

// Array of NUIGridLength
@property (nonatomic, copy) NSArray *rows;
@property (nonatomic, copy) NSArray *columns;
@property (nonatomic, assign) NUIGridLayoutInsertionMethod insertionMethod;

// columns and rows are array of strings. they are passed to initWithString: of GridLength
- (id)initWithColumns:(NSArray *)columns rows:(NSArray *)rows;

- (void)setColumns:(NSArray *)columns rows:(NSArray *)rows;

- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view;
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view column:(NSUInteger)column row:(NSUInteger)row;
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view columnRange:(NSRange)columnRange
    rowRange:(NSRange)rowRange;
- (NUIGridLayoutItem *)addSubview:(id<NUIView>)view columns:(NSUInteger)columns
    rows:(NSUInteger)rows;
- (void)removeSubview:(id<NUIView>)view;

// Including auto-generated
- (NSUInteger)columnsCount;
- (NSUInteger)rowsCount;

@end
