//
//  NUIGridLayoutItem.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILayoutItem.h"

@interface NUIGridLayoutItem : NUILayoutItem

@property (nonatomic, assign) NSRange columnRange;
@property (nonatomic, assign) NSRange rowRange;
@property (nonatomic, assign) int column;
@property (nonatomic, assign) int row;

@end
