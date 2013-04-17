//
//  NUILoader+StructuresLoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUILoader.h"

/*! To parse a struct add a method to NUILoader with the signature:
 *  - (BOOL)load<struct name>PropertyOfObject:(id)object setter:(SEL)setter value:(id)rvalue
 *  error:(NUIError **)error
 */
@interface NUILoader (StructuresLoading)

- (BOOL)loadCGSizePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
    error:(NUIError **)error;
- (BOOL)loadCGRectPropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
    error:(NUIError **)error;
- (BOOL)loadNSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
    error:(NUIError **)error;
- (BOOL)load_NSRangePropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
    error:(NUIError **)error;
- (BOOL)loadUIEdgeInsetsPropertyOfObject:(id)object setter:(SEL)setter value:(NUIStatement *)value
    error:(NUIError **)error;
- (BOOL)loadCGAffineTransformPropertyOfObject:(id)object setter:(SEL)setter
    value:(NUIStatement *)value error:(NUIError **)error;

@end