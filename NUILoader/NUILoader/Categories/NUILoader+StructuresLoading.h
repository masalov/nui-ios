//
//  NUILoader+StructuresLoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUILoader.h"

// To parse a struct add a method to NUILoader with the signature:
// - (BOOL)load<struct name>PropertyOfObject:(id)object setter:(SEL)setter value:(id)rvalue
@interface NUILoader (StructuresLoading)

- (BOOL)loadCGSizePropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value;
- (BOOL)loadCGRectPropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value;
- (BOOL)loadNSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value;
- (BOOL)loadUIEdgeInsetsPropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value;
- (BOOL)loadCGAffineTransformPropertyOfObject:(id)object setter:(SEL)setter value:(NSArray *)value;

@end