//
//  NUILoader.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUILoader.h"
#import <objc/message.h>
#import <Foundation/Foundation.h>
#import "NUIData.h"
#import "NUIAnalyzer.h"
#import "NUIStatement+Object.h"
#import "NUIStatement+BinaryOperator.h"
#import "NUIError.h"

#import "nui_utils.h"

static SEL setterFromProperty(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [[property substringToIndex:1]
        capitalizedString], [property substringFromIndex:1]]);
}

static SEL nuiLoaderFromProperty(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"loadNUI%@%@FromRValue:loader:error:",
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

static SEL propertyConstantsGetter(NSString *property)
{
    return NSSelectorFromString([NSString stringWithFormat:@"nuiConstantsFor%@%@", [[property substringToIndex:1]
        capitalizedString], [property substringFromIndex:1]]);
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
@synthesize lastError = lastError_;

- (id)initWithRootObject:(id)rootObject
{
    self = [super init];
    if (self) {
        rootObject_ = rootObject;
        globalObjects_ = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"YES",
            [NSNumber numberWithBool:NO], @"NO",
            nil];
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
    [lastError_ release];

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
    self.lastError = nil;
    return [self loadFromFile:file mainFile:YES];
}

- (BOOL)loadState:(NSString *)state
{
    NUIStatement *nuiObject = [states_ objectForKey:state];
    if (!nuiObject) {
        NSLog(@"Unkonw state \"%@\"", state);
        return NO;
    }
    for (NUIStatement *op in nuiObject.properties) {
        NUIStatement *identifier = op.lvalue;
        if (op.statementType == NUIStatementType_AssignmentOperator) {
            NSRange range = [identifier.value rangeOfString:@"." options:NSBackwardsSearch];
            if (!range.length) {
                NSAssert(NO, @"Can set only object properties, not an object");
                return NO;
            }
            id object = [self globalObjectForKey:[identifier.value substringToIndex:range.location]];
            if (!object) {
                NSAssert(NO, @"Object \"%@\" not found", [identifier.value
                    substringToIndex:range.location]);
                return NO;
            }
            if (![self assignObject:object property:[identifier.value
                substringFromIndex:range.location + range.length] value:op.rvalue]) {
                NSAssert(NO, @"Failed to load property \"%@\"", [identifier.value
                    substringFromIndex:range.location + range.length]);
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

- (id)loadObjectOfClass:(Class)cls fromNUIObject:(NUIStatement *)nuiObject
{
    Class subclass = nil;
    NUIStatement *className = [nuiObject.systemProperties objectForKey:@":class"];
    if (className) {
        subclass = NSClassFromString(className.value);
    }
    if (subclass) {
        if (!isSuperClass(subclass, cls)) {
            self.lastError = [NUIError errorWithData:className.data position:
                className.range.location message:[NSString stringWithFormat:
                @"Expecting subclass of %@, not %@", NSStringFromClass(cls), className.value]];
            return nil;
        }
    } else {
        subclass = cls;
    }
    if ([subclass respondsToSelector:@selector(loadFromNUIObject:loader:error:)]) {
        NUIError *error = nil;
        id object = [subclass loadFromNUIObject:nuiObject loader:self error:&error];
        self.lastError = error;
        return object;
    }
    id object = [[[subclass alloc] init] autorelease];
    if (![self loadObject:object fromNUIObject:nuiObject]) {
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
        NUIStatement *constant = [constants_ objectForKey:objectId];
        if (constant) {
            if (constant.statementType == NUIStatementType_Object) {
                NUIStatement *className = [constant.systemProperties objectForKey:@":class"];
                Class cl = NSClassFromString(className.value);
                if ([cl respondsToSelector:@selector(loadFromNUIObject:loader:error:)]) {
                    NUIError *error = nil;
                    object = [cl loadFromNUIObject:constant loader:self error:&error];
                    self.lastError = error;
                } else {
                    object = [[[cl alloc] init] autorelease];
                    [self loadObject:object fromNUIObject:constant];
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

- (NSNumber *)calculateNumericExpression:(NUIStatement *)expression
    constants:(NSDictionary *)constants
{
    if (expression.statementType == NUIStatementType_Number) {
        return expression.value;
    }
    if (expression.statementType == NUIStatementType_Identifier) {
        id res = [constants objectForKey:expression.value];
        if (!res) {
            res = [self globalObjectForKey:expression.value];
        }
        return res;
    }
    if ([expression isBinaryOperator]) {
        NSNumber *lvalue = [self calculateNumericExpression:expression.lvalue constants:constants];
        if (!lvalue) {
            return nil;
        }
        NSNumber *rvalue = [self calculateNumericExpression:expression.rvalue constants:constants];
        if (!rvalue) {
            return nil;
        }
        switch (expression.statementType) {
            case NUIStatementType_BitwiseOrOperator:
                return [NSNumber numberWithInt:([lvalue intValue] | [rvalue intValue])];
            default:
                return nil;
        }
    }
    return nil;
}

#pragma mark - private methods

- (void)logError:(NUIError *)error data:(NUIData *)data
{
    if (error) {
        NUIPositionInLine pos = [data positionInLineFromPosition:error.position];
        NSLog(@"Error in file: \"%@\" line: %d position: %d.\nError: %@", data.fileName, pos.line +
            1, pos.position + 1, error.message);
    } else {
        NSLog(@"Unknown error in file: \"%@\"", data.fileName);
    }
}

- (BOOL)loadFromFile:(NSString *)file mainFile:(BOOL)mainFile
{
    NUIData *data = [[[NUIData alloc] init] autorelease];
    data.fileName = file;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    if (!fullPath) {
        NSLog(@"Can not find file \"%@\"", file);
        return NO;
    }
    NSError *error = nil;
    data.data = [[[NSString alloc] initWithContentsOfFile:fullPath
        encoding:NSUTF8StringEncoding error:&error] autorelease];
    if (!data.data || error) {
        NSLog(@"Can not load file \"%@\": %@", file, [error description]);
        return NO;
    }
    NUIAnalyzer *analyzer = [[[NUIAnalyzer alloc] initWithData:data] autorelease];
    if (![analyzer loadImports]) {
        [self logError:analyzer.lastError data:data];
        return NO;
    }
    for (NSString *f in analyzer.imports) {
        if (![self loadFromFile:f mainFile:NO]) {
            return NO;
        }
    }
    if (![analyzer loadContentFromMainFile:mainFile]) {
        [self logError:analyzer.lastError data:data];
        return NO;
    }
    [constants_ addEntriesFromDictionary:analyzer.constants];
    [styles_ addEntriesFromDictionary:analyzer.styles];
    [states_ addEntriesFromDictionary:analyzer.states];
    if (mainFile && ![self loadRootObjectFromNUIObject:analyzer.rootObject]) {
        [self logError:self.lastError data:data];
        return NO;
    }
    return YES;
}

- (BOOL)loadRootObjectFromNUIObject:(NUIStatement *)object
{
    if (![self loadObject:rootObject_ fromNUIObject:object]) {
        return NO;
    }
    return YES;
}

- (BOOL)loadObject:(id)object fromNUIObject:(NUIStatement *)nuiObject
{
    for (NSString *key in nuiObject.systemProperties) {
        NUIStatement *rvalue = [nuiObject.systemProperties objectForKey:key];
        if (rvalue.statementType != NUIStatementType_Identifier) {
            self.lastError = [NUIError errorWithData:rvalue.data position:
                rvalue.range.location message:@"Expecting an identifier."];
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
        /*NSAssert(NO, @"Error");
        return NO;*/
    }
    for (NUIStatement *op in nuiObject.properties) {
        NUIStatement *identifier = op.lvalue;
        if (op.statementType == NUIStatementType_AssignmentOperator) {
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
            if (![self loadObject:[object valueForKeyPath:identifier.value]
                fromNUIObject:op.rvalue]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)assignObject:(id)object property:(NSString *)property value:(NUIStatement *)rvalue
{
    SEL sel = nuiLoaderFromProperty(property);
    if ([object respondsToSelector:sel]) {
        NUIError *error = nil;
        BOOL res =  ((BOOL (*)(id, SEL, id, id, NUIError **))objc_msgSend)(object, sel, rvalue,
            self, &error);
        self.lastError = error;
        return res;
    }
    // Assigning to global object property
    if (rvalue.statementType == NUIStatementType_Identifier) {
        id value = [self globalObjectForKey:rvalue.value];
        if (value) {
            [object setValue:value forKey:property];
            return YES;
        }
    }
    sel = setterFromProperty(property);
    if ([object respondsToSelector:sel]) {
        SEL parser = propertyParser([object class], property);
        if (parser && [self respondsToSelector:parser]) {
            objc_msgSend(self, parser, object, property, rvalue);
            return YES;
        }
        if ([rvalue isKindOfClass:[NSString class]]) {
            objc_msgSend(object, sel, (NSString *)(rvalue.value));
            return YES;
        }
        if (rvalue.statementType == NUIStatementType_Object) {
            NUIStatement *className = [rvalue.systemProperties objectForKey:@":class"];
            Class cl = nil;
            if (className) {
                cl = NSClassFromString(className.value);
                if (cl == nil) {
                    self.lastError = [NUIError errorWithData:className.data position:
                        className.range.location message:[NSString stringWithFormat:
                        @"Unknown class name: %@.", className]];
                    return NO;
                }
            }
            NSString *defaultClassName = propertyClassName([object class], property);
            if (!defaultClassName) {
                self.lastError = [NUIError errorWithData:rvalue.data position:
                    rvalue.range.location message:[NSString stringWithFormat:
                    @"Can not get name of default class of %@ property.", property]];
                return NO;
            }
            Class defaultCl = NSClassFromString(defaultClassName);
            if (cl && !isSuperClass(cl, defaultCl)) {
                self.lastError = [NUIError errorWithData:className.data position:
                    className.range.location message:[NSString stringWithFormat:
                    @"%@ is no a subclass of %@.", className, defaultClassName]];
                return NO;
            }
            id value = [[[cl ? cl : defaultCl alloc] init] autorelease];
            [self loadObject:value fromNUIObject:rvalue];
            objc_msgSend(object, sel, value);
            return YES;
        }
        NSMethodSignature *sign = [[object class] instanceMethodSignatureForSelector:sel];
        const char *type = [sign getArgumentTypeAtIndex:2];
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
        return [self assignObject:object property:property type:type numericExpression:rvalue];
    }
    self.lastError = [NUIError errorWithData:rvalue.data position:
        rvalue.range.location message:[NSString stringWithFormat:@"%@ doesn't have %@ property.",
        NSStringFromClass([object class]), property]];
    return NO;
}

- (BOOL)assignObject:(id)object property:(NSString *)property type:(const char *)type
    numericExpression:(id)expression
{
    NSDictionary *constants = nil;
    SEL constantsGetter = propertyConstantsGetter(property);
    if ([[object class] respondsToSelector:constantsGetter]) {
        constants = [[object class] performSelector:constantsGetter];
    }
    NSNumber *value = [self calculateNumericExpression:expression
        constants:constants];
    if (!value) {
        return NO;
    }
    SEL sel = setterFromProperty(property);
    if (strcmp(@encode(BOOL), type) == 0) {
        BOOL v = [value boolValue];
        ((void (*)(id, SEL, BOOL))objc_msgSend)(object, sel, v);
    } else if (strcmp(@encode(float), type) == 0) {
        float v = [value floatValue];
        ((void (*)(id, SEL, float))objc_msgSend)(object, sel, v);
    } else if (strcmp(@encode(int), type) == 0) {
        int v = [value intValue];
        objc_msgSend(object, sel, v);
    } else if (strcmp(@encode(unsigned int), type) == 0) {
        unsigned int v = [value unsignedIntValue];
        ((void (*)(id, SEL, unsigned int))objc_msgSend)(object, sel, v);
    } else if (strcmp(@encode(long), type) == 0) {
        long v = [value longValue];
        ((void (*)(id, SEL, long))objc_msgSend)(object, sel, v);
    } else if (strcmp(@encode(double), type) == 0) {
        double v = [value doubleValue];
        objc_msgSend(object, sel, v);
    } else if (strcmp(@encode(long long), type) == 0) {
        long long v = [value longLongValue];
        ((void (*)(id, SEL, long long))objc_msgSend)(object, sel, v);
    } else {
        return NO;
    }
    return YES;
}

@end