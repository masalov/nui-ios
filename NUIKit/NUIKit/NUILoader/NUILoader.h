//
//  NUILoader.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIObject;

// Class for loading objects from NUI files.
//
// Properties can be set via methods with the following signatures:
// set<Propery name>:
// setNUI<Propery name>:(NSString *)value
// loadNUI<Propery name>FromRValue:(id)rvalue loader:(NUILoader *)loader
//
// To add support for loading a struct from a string for any property add method to NUILoader with
// signature: load<struct name>PropertyOfObject:setter:value:
// See NUILoader (StructuresLoading) for examples.
//
// To add support for loading an object from a string for any property add method to NUILoader with
// signature: load<class name>PropertyOfObject:property:value:
// See NUILoader (ObjectsLoading) for examples.
@interface NUILoader : NSObject

@property (nonatomic, assign, readonly) id rootObject;

- (id)initWithRootObject:(id)rootObject;

- (void)reset;
- (BOOL)loadFromFile:(NSString *)file;

- (BOOL)loadState:(NSString *)state;
- (void)resetRootObjectProperties;


- (id)loadObjectOfClass:(Class)cls fromNUIObject:(NUIObject *)nuiObject;

- (id)globalObjectForKey:(id)key;

- (NSNumber *)calculateNumericExpression:(id)expression constants:(NSDictionary *)constants;

@end

// Implement this protocol for objects that can't be constructed by [[<Class> alloc] init].
@protocol NUILoadingObject <NSObject>

@optional

+ (id)loadFromNUIObject:(NUIObject *)nuiObject loader:(NUILoader *)loader;

@end