//
//  NUILoader.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIStatement;
@class NUIError;

// Class for loading objects from NUI files.
//
// Properties can be set via methods with the following signatures:
// set<Property name>:
// loadNUI<Property name>FromRValue:(id)rvalue loader:(NUILoader *)loader error:(NUIError **)error
//
// To add support for loading a struct from a string for any property add method to NUILoader with
// signature: load<struct name>PropertyOfObject:setter:value:error:
// See NUILoader (StructuresLoading) for examples.
//
// To add support for loading an object from a string for any property add method to NUILoader with
// signature: load<class name>PropertyOfObject:property:value:error:
// See NUILoader (ObjectsLoading) for examples.
@interface NUILoader : NSObject

@property (nonatomic, assign, readonly) id rootObject;
@property (nonatomic, retain) NUIError *lastError;
@property (nonatomic, retain, readonly) NSDictionary *styles;

- (id)initWithRootObject:(id)rootObject;

- (void)reset;
- (BOOL)loadFromFile:(NSString *)file;

- (BOOL)loadState:(NSString *)state;
- (void)resetRootObjectProperties;


- (BOOL)loadObject:(id)object fromNUIObject:(NUIStatement *)nuiObject;
- (BOOL)loadObject:(id)object fromNUIObject:(NUIStatement *)nuiObject logErrors:(BOOL)logErrors;
- (id)loadObjectOfClass:(Class)cls fromNUIObject:(NUIStatement *)nuiObject;

- (id)globalObjectForKey:(id)key;

- (NSNumber *)calculateNumericExpression:(NUIStatement *)expression
    containingObject:(id)containingObject constants:(NSDictionary *)constants;
- (NSArray *)calculateArrayOfNumericExpressions:(NUIStatement *)array
    containingObject:(id)containingObject;

@end

// Implement this protocol for objects that can't be constructed by [[<Class> alloc] init].
@protocol NUILoadingObject <NSObject>

@optional

+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end