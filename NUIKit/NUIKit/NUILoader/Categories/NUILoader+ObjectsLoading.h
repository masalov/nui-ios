//
//  NUILoader+ObjectsLoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUILoader.h"

// To parse a struct add a method to NUILoader with the signature:
// - (BOOL)load<class name>PropertyOfObject:(id)object property:(NSString *)property value:(id)rvalue
@interface NUILoader (ObjectsLoading)

- (BOOL)loadUIColorPropertyOfObject:(id)object property:(NSString *)property value:(id)rvalue;

@end