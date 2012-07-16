//
//  NUILoader.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader.h"
#import <objc/message.h>
#import "NUIAnalyzer.h"
#import "NUIObject.h"
#import "NUIIdentifier.h"
#import "NUIBinaryOperator.h"

#import "nui_utils.h"

static SEL setterFromProperty(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [[property substringToIndex:1]
        capitalizedString], [property substringFromIndex:1]]);
}

static SEL nuiSetterFromProperty(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"setNUI%@%@:", [[property substringToIndex:1]
        capitalizedString], [property substringFromIndex:1]]);
}

static SEL nuiLoaderFromProperty(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"loadNUI%@%@FromRValue:loader:",
        [[property substringToIndex:1] capitalizedString], [property substringFromIndex:1]]);
}

static SEL structPropertyParser(NSString *structName)
{
    return NSSelectorFromString([NSString stringWithFormat:@"load%@PropertyOfObject:setter:value:", structName]);
}

static SEL propertyParser(Class class, NSString *propertyName)
{
    NSString *className = propertyClassName(class, propertyName);
    if (className) {
        return NSSelectorFromString([NSString stringWithFormat:@"load%@PropertyOfObject:property:value:", className]);
    }
    return nil;
}

@interface NUILoader ()
{
    id rootObject_;
    NSMutableDictionary *globalObjects_;
    NSMutableSet *rootProperties_;
    NSMutableDictionary *constants_;
    NSMutableDictionary *styles_;
    NSMutableDictionary *states_;
}

@end

@implementation NUILoader

@synthesize rootObject = rootObject_;

- (id)initWithRootObject:(id)rootObject
{
    self = [super init];
    if (self) {
        rootObject_ = rootObject;
        globalObjects_ = [[NSMutableDictionary alloc] init];
        rootProperties_ = [[NSMutableSet alloc] init];
        constants_ = [[NSMutableDictionary alloc] init];
        styles_ = [[NSMutableDictionary alloc] init];
        states_ = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [globalObjects_ release];
    [rootProperties_ release];
    [constants_ release];
    [styles_ release];
    [states_ release];

    [super dealloc];
}

- (void)reset
{
    [constants_ removeAllObjects];
    [styles_ removeAllObjects];
    [states_ removeAllObjects];
}

- (BOOL)loadFromFile:(NSString *)file
{
    return [self loadFromFile:file mainFile:YES];
}

- (BOOL)loadState:(NSString *)state
{
    NUIObject *nuiObject = [states_ objectForKey:state];
    for (NUIBinaryOperator *op in nuiObject.properties) {
        NUIIdentifier *identifier = op.lvalue;
        if (op.type == NUIBinaryOperatorType_Assignment) {
            NSRange range = [identifier.value rangeOfString:@"." options:NSBackwardsSearch];
            if (!range.length) {
                return NO;
            }
            id object = [self globalObjectForKey:[identifier.value substringToIndex:range.location]];
            if (!object) {
                return NO;
            }
            if (![self assignObject:object property:[identifier.value substringFromIndex:range.location + range.length]
                value:op.rvalue]) {
                return NO;
            }
        } else {
            id object = [self globalObjectForKey:identifier.value];
            if (![self loadObject:object fromNUIObject:op.rvalue]) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)resetRootObjectProperties
{
    for (NSString *name in rootProperties_) {
        SEL sel = setterFromProperty(name);
        [rootObject_ performSelector:sel withObject:nil];
    }
}

- (id)loadObjectOfClass:(Class)cls fromNUIObject:(NUIObject *)nuiObject
{
    Class subclass = nil;
    if (nuiObject.type) {
        subclass = NSClassFromString(nuiObject.type);
    }
    if (subclass) {
        if (!isSuperClass(subclass, cls)) {
            NSAssert(NO, @"Wrong class.");
            return NO;
        }
    } else {
        subclass = cls;
    }
    if ([subclass respondsToSelector:@selector(loadFromNUIObject:loader:)]) {
        return [subclass loadFromNUIObject:nuiObject loader:self];
    }
    id object = [[[subclass alloc] init] autorelease];
    if (![self loadObject:object fromNUIObject:nuiObject]) {
        NSAssert(NO, @"Failed to load.");
        return nil;
    }
    return object;
}

- (id)globalObjectForKey:(id)key
{
    // If key is an identifier of kind a.b.c, get object for first part and than use valueForKeyPath
    id objectId = key;
    NSRange range = [key rangeOfString:@"."];
    if (range.length) {
        objectId = [key substringToIndex:range.location];
    }
    id object = [globalObjects_ objectForKey:objectId];
    if (!object) {
        id constant = [constants_ objectForKey:objectId];
        if (constant) {
            if ([constant isKindOfClass:[NUIObject class]]) {
                NUIObject *nuiObject = (id)constant;
                NSString *className = nuiObject.type;
                Class cl = NSClassFromString(className);
                if ([cl respondsToSelector:@selector(loadFromNUIObject:loader:)]) {
                    object = [cl loadFromNUIObject:nuiObject loader:self];
                } else {
                    object = [[[cl alloc] init] autorelease];
                    [self loadObject:object fromNUIObject:nuiObject];
                }
            }
            if (object) {
                [globalObjects_ setObject:object forKey:objectId];
            }
        }
    }
    if (range.length) {
        object = [object valueForKeyPath:[key substringFromIndex:range.location + range.length]];
    }
    return object;
}

#pragma mark - private methods

- (BOOL)loadFromFile:(NSString *)file mainFile:(BOOL)mainFile
{
    file = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    if (!file) {
        NSAssert(NO, @"Can not find file \"%@\"", file);
        return NO;
    }
    NSError *error = nil;
    NSString *text = [[[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error]
        autorelease];
    if (!text || error) {
        NSAssert(NO, @"Can not load file \"%@\": %@", file, [error description]);
        return NO;
    }
    NUIAnalyzer *analyzer = [[[NUIAnalyzer alloc] initWithString:text] autorelease];
    if (![analyzer loadImports]) {
        return NO;
    }
    for (NSString *f in analyzer.imports) {
        if (![self loadFromFile:f mainFile:NO]) {
            return NO;
        }
    }
    if (![analyzer loadContentFromMainFile:mainFile]) {
        return NO;
    }
    [constants_ addEntriesFromDictionary:analyzer.constants];
    [styles_ addEntriesFromDictionary:analyzer.styles];
    [states_ addEntriesFromDictionary:analyzer.states];
    if (mainFile) {
        return [self loadRootObjectFromNUIObject:analyzer.rootObject];
    }
    return YES;
}

- (BOOL)loadRootObjectFromNUIObject:(NUIObject *)object
{
    if (![self loadObject:rootObject_ fromNUIObject:object]) {
        return NO;
    }
    return YES;
}

- (BOOL)loadObject:(id)object fromNUIObject:(NUIObject *)nuiObject
{
    for (NSString *key in nuiObject.systemProperties) {
        NUIIdentifier *rvalue = [nuiObject.systemProperties objectForKey:key];
        if (![rvalue isKindOfClass:[NUIIdentifier class]]) {
            return NO;
        }
        // Set id
        if ([key isEqualToString:@":id"]) {
            [globalObjects_ setObject:object forKey:rvalue.value];
            continue;
        }
        // Set root property
        if ([key isEqualToString:@":property"]) {
            [rootObject_ setValue:object forKeyPath:rvalue.value];
            [rootProperties_ addObject:rvalue.value];
            continue;
        }
        // Load style
        if ([key isEqualToString:@":style"]) {
            if (![self loadObject:object fromNUIObject:[styles_ objectForKey:rvalue.value]]) {
                return NO;
            }
            continue;
        }
        NSAssert(NO, @"Error");
        return NO;
    }
    for (NUIBinaryOperator *op in nuiObject.properties) {
        NUIIdentifier *identifier = op.lvalue;
        if (op.type == NUIBinaryOperatorType_Assignment) {
            if (object == rootObject_) {
                [rootProperties_ addObject:identifier.value];
            }
            id propertyObj = object;
            NSString *propertyId = identifier.value;
            NSRange r = [propertyId rangeOfString:@"." options:NSBackwardsSearch];
            if (r.length) {
                propertyObj = [propertyObj valueForKeyPath:[propertyId substringToIndex:r.location]];
                propertyId = [propertyId substringFromIndex:r.location + r.length];
            }
            if (![self assignObject:propertyObj property:propertyId value:op.rvalue]) {
                return NO;
            }
        } else {
            if (![self loadObject:[object valueForKeyPath:identifier.value] fromNUIObject:op.rvalue]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)assignObject:(id)object property:(NSString *)property value:(id)rvalue
{
    SEL sel = nuiLoaderFromProperty(property);
    if ([object respondsToSelector:sel]) {
        return ((BOOL (*)(id, SEL, id, id))objc_msgSend)(object, sel, rvalue, self);
    }
    sel = nuiSetterFromProperty(property);
    if ([object respondsToSelector:sel]) {
        [object performSelector:sel withObject:rvalue];
    } else {
        // Assigning to global object property
        if ([rvalue isKindOfClass:[NUIIdentifier class]]) {
            NUIIdentifier *prop = (id)rvalue;
            id value = [self globalObjectForKey:prop.value];
            if (value) {
                [object setValue:value forKey:property];
                return YES;
            }
        }
        sel = setterFromProperty(property);
        if ([object respondsToSelector:sel]) {
            NSMethodSignature *sign = [[object class] instanceMethodSignatureForSelector:sel];
            const char *type = [sign getArgumentTypeAtIndex:2];
            if ([rvalue isKindOfClass:[NSNumber class]]) {
                return [self assignObject:object selector:sel type:type number:(id)rvalue];
            }
            if ([rvalue isKindOfClass:[NUIIdentifier class]]) {
                return [self assignObject:object selector:sel type:type boolValue:(id)rvalue];
            }
            int len = strlen(type);
            if (len > 1 && type[0] == '{') {
                for (int i = 0; i < len; ++i) {
                    if (type[i] == '=') {
                        NSString *tmp = [[[NSString alloc] initWithBytes:type + 1 length:i - 1
                            encoding:NSASCIIStringEncoding] autorelease];
                        SEL parser = structPropertyParser(tmp);
                        if ([self respondsToSelector:parser]) {
                            objc_msgSend(self, parser, object, sel, rvalue);
                            return YES;
                        }
                    }
                }
            }
            SEL parser = propertyParser([object class], property);
            if (parser && [self respondsToSelector:parser]) {
                objc_msgSend(self, parser, object, property, rvalue);
                return YES;
            }
            if ([rvalue isKindOfClass:[NSString class]]) {
                objc_msgSend(object, sel, (NSString *)rvalue);
                return YES;
            }
            if ([rvalue isKindOfClass:[NUIObject class]]) {
                NUIObject *nuiObject = rvalue;
                NSString *className = nuiObject.type;
                Class cl = nil;
                if (className) {
                    cl = NSClassFromString(className);
                    if (cl == nil) {
                        return NO;
                    }
                }
                NSString *defaultClassName = propertyClassName([object class], property);
                if (!defaultClassName) {
                    return NO;
                }
                Class defaultCl = NSClassFromString(className);
                if (cl && !isSuperClass(cl, defaultCl)) {
                    return NO;
                }
                id value = [[[cl ? cl : defaultCl alloc] init] autorelease];
                [self loadObject:value fromNUIObject:nuiObject];
                objc_msgSend(object, sel, value);
                return YES;
            }
        }
    }
    NSAssert(NO, @"Object doesn't have %@ property", property);
    return NO;
}

- (BOOL)assignObject:(id)object selector:(SEL)sel type:(const char *)type number:(NSNumber *)value
{
    if (strcmp(@encode(float), type) == 0) {
        float v = [value floatValue];
        ((void (*)(id, SEL, float))objc_msgSend)(object, sel, v);
    } else if (strcmp(@encode(double), type) == 0) {
        double v = [value doubleValue];
        objc_msgSend(object, sel, v);
    } else if (strcmp(@encode(int), type) == 0) {
        int v = [value intValue];
        objc_msgSend(object, sel, v);
    } else if (strcmp(@encode(long long), type) == 0) {
        long long v = [value longLongValue];
        ((void (*)(id, SEL, long long))objc_msgSend)(object, sel, v);
    } else {
        return NO;
    }
    return YES;
}

- (BOOL)assignObject:(id)object selector:(SEL)sel type:(const char *)type boolValue:(NUIIdentifier *)value
{
    if (strcmp(@encode(BOOL), type) == 0) {
        if ([value.value compare:@"YES" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            ((void (*)(id, SEL, BOOL))objc_msgSend)(object, sel, YES);
        } else {
            ((void (*)(id, SEL, BOOL))objc_msgSend)(object, sel, NO);
        }
        return YES;
    }
    return NO;
}

@end