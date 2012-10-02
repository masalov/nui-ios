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

/*! Class for loading objects from NUI files.
 *
 *  Properties can be set via methods with the following signatures:
 *  * set<Property name>:
 *  * loadNUI<Property name>FromRValue:loader:error:
 *
 *  To add support for loading a struct for any property add method to \b NUILoader with
 *  signature: load<struct name>PropertyOfObject:setter:value:error:
 *  See NUILoader (StructuresLoading) for examples.
 *
 *  To add support for loading an object (that can't be constructed by [[<Class> alloc] init]) from
 *  a nui object for any property implement \b NUILoadingObject protocol.
 *
 *  To add support for loading an object from a string or other non-object statement for any
 *  property add method to \b NUILoader with signature:
 *  load<class name>PropertyOfObject:property:value:error:
 *  See NUILoader (ObjectsLoading) for examples.
 */
@interface NUILoader : NSObject

@property (nonatomic, assign, readonly) id rootObject;
@property (nonatomic, retain) NUIError *lastError;
@property (nonatomic, retain, readonly) NSDictionary *styles;

- (id)initWithRootObject:(id)rootObject;

/*! Clears states, constants and styles. */
- (void)reset;
/*! Loads data from a file. Main method. */
- (BOOL)loadFromFile:(NSString *)file;

/*! Loads state with specified name. */
- (BOOL)loadState:(NSString *)state;
/*! Sets to nil root object properties that were set during loading. */
- (void)resetRootObjectProperties;

/*! Load NUI object or style into an object. */
- (BOOL)loadObject:(id)object fromNUIObject:(NUIStatement *)nuiObject;
/*! Load NUI object or style into an object. If \b logErrors set to \b YES, prints errors to the
 *  Application output.
 */
- (BOOL)loadObject:(id)object fromNUIObject:(NUIStatement *)nuiObject logErrors:(BOOL)logErrors;
/*! Constructs an object from NUI object. */
- (id)loadObjectOfClass:(Class)cls fromNUIObject:(NUIStatement *)nuiObject;
/*! Returns an object or a constant with specified identifier. Indetifier can contain a key path to
 *  a property.
 */
- (id)globalObjectForKey:(id)key;

- (NSNumber *)calculateNumericExpression:(NUIStatement *)expression
    containingObject:(id)containingObject constants:(NSDictionary *)constants;
- (NSArray *)calculateArrayOfNumericExpressions:(NUIStatement *)array
    containingObject:(id)containingObject;

@end

/*! Implement this protocol for objects that can't be constructed by [[<Class> alloc] init]. */
@protocol NUILoadingObject <NSObject>

@optional

+ (id)loadFromNUIObject:(NUIStatement *)nuiObject loader:(NUILoader *)loader
    error:(NUIError **)error;

@end