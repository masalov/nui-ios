//
//  NUIGridLayoutItem.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayoutItem.h"

/*! A layout item used by \b NUIGridLayout. */
@interface NUIGridLayoutItem : NUILayoutItem

/*! A range of columns. Default value is [0, 1]. */
@property (nonatomic, assign) NSRange columnRange;
/*! A range of rows. Default value is [0, 1]. */
@property (nonatomic, assign) NSRange rowRange;
/*! A column number. Default value is 0. */
@property (nonatomic, assign) int column;
/*! A row number. Default value is 0. */
@property (nonatomic, assign) int row;

@end
