//
//  NUIAnalyzer.m
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIAnalyzer.h"
#import <objc/message.h>
#import "NUIIdentifier.h"
#import "NUIBinaryOperator.h"
#import "NUIObject.h"

static NSString *Digits = @"0123456789";
static NSString *FirstIdentifierSymbols = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_";
static NSString *IdentifierSymbols = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789.";
static NSString *SimpleIdentifierSymbols = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789";
static NSString *Punctuation = @";,";
static NSString *SystemIdentifierSymbols = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

@interface NUIAnalyzer ()
{
    NSCharacterSet *digits_;
    NSCharacterSet *firstIdentifierSymbols_;
    NSCharacterSet *identifierSymbols_;
    NSCharacterSet *simpleIdentifierSymbols_;
    NSCharacterSet *systemIdentifierSymbols_;
    NSCharacterSet *punctuation_;

    NSString *string_;
    int position_;
    NSMutableArray *imports_;
    NSMutableDictionary *constants_;
    NSMutableDictionary *styles_;
    NSMutableDictionary *states_;
}

@end

@implementation NUIAnalyzer

@synthesize imports = imports_;
@synthesize constants = constants_;
@synthesize styles = styles_;
@synthesize states = states_;
@synthesize rootObject = rootObject_;

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        digits_ = [[NSCharacterSet characterSetWithCharactersInString:Digits] retain];
        firstIdentifierSymbols_ = [[NSCharacterSet characterSetWithCharactersInString:FirstIdentifierSymbols] retain];
        identifierSymbols_ = [[NSCharacterSet characterSetWithCharactersInString:IdentifierSymbols] retain];
        simpleIdentifierSymbols_ = [[NSCharacterSet characterSetWithCharactersInString:SimpleIdentifierSymbols] retain];
        systemIdentifierSymbols_ = [[NSCharacterSet characterSetWithCharactersInString:SystemIdentifierSymbols] retain];
        punctuation_ = [[NSCharacterSet characterSetWithCharactersInString:Punctuation] retain];

        string_ = [string copy];
        imports_ = [[NSMutableArray alloc] init];
        constants_ = [[NSMutableDictionary alloc] init];
        styles_ = [[NSMutableDictionary alloc] init];
        states_ = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [digits_ release];
    [firstIdentifierSymbols_ release];
    [identifierSymbols_ release];
    [simpleIdentifierSymbols_ release];
    [systemIdentifierSymbols_ release];
    [punctuation_ release];

    [string_ release];
    [imports_ release];
    [constants_ release];
    [styles_ release];
    [states_ release];
    [rootObject_ release];

    [super dealloc];
}

- (BOOL)loadImports
{
    while (YES) {
        if (![self skipSpacesAndPunctuation:&position_]) {
            return YES;
        }
        int startPos = position_;
        NUIIdentifier *identifier = [self loadIdentifier:&startPos];
        if (!identifier) {
            return YES;
        }
        if (![identifier.value isEqualToString:@"import"]) {
            return YES;
        }
        position_ = startPos;
        if (![self skipSpacesAndPunctuation:&position_]) {
            return NO;
        }
        NSString *str = [self loadString:&position_];
        if (!str) {
            return NO;
        }
        [imports_ addObject:str];
    }
}

- (BOOL)loadContentFromMainFile:(BOOL)mainFile
{
    while (YES) {
        if (![self skipSpacesAndPunctuation:&position_]) {
            return YES;
        }
        NUIIdentifier *identifier = [self loadIdentifier:&position_];
        if (!identifier) {
            return NO;
        }
        if (![self skipSpacesAndPunctuation:&position_]) {
            return NO;
        }
        if ([identifier.value isEqualToString:@"const"]) {
            NUIBinaryOperator *op = [self loadBinaryOperator:@"=" lvalueLoader:@selector(loadSimpleIdentifier:)
                rvalueLoader:@selector(loadRValue:) position:&position_];
            [constants_ setObject:op.rvalue forKey:op.lvalue];
            continue;
        } else if ([identifier.value isEqualToString:@"style"]) {
            NUIBinaryOperator *op = [self loadBinaryOperator:@"=" lvalueLoader:@selector(loadSimpleIdentifier:)
                rvalueLoader:@selector(loadObject:) position:&position_];
            [styles_ setObject:op.rvalue forKey:op.lvalue];
            continue;
        } else if ([identifier.value isEqualToString:@"state"]) {
            NUIBinaryOperator *op = [self loadBinaryOperator:@"=" lvalueLoader:@selector(loadSimpleIdentifier:)
                rvalueLoader:@selector(loadObject:) position:&position_];
            [states_ setObject:op.rvalue forKey:op.lvalue];
            continue;
        } else if (mainFile) {
            if ([identifier.value isEqualToString:@"binding"]) {
                /*Statement *st = nil;
                NSString *oper = @"{";
                if ([string_ compare:oper options:0 range:(NSRange){position, oper.length}] == NSOrderedSame) {
                    st = [self loadDictionary];
                } else {
                    st = [self loadAssignment];
                }*/
                continue;
            } else if ([identifier.value isEqualToString:@"self"]) {
                NSString *op = @"=";
                if ([string_ compare:op options:0 range:(NSRange){position_, op.length}] != NSOrderedSame) {
                    return NO;
                }
                position_ += op.length;
                if (![self skipSpacesAndPunctuation:&position_]) {
                    return NO;
                }
                rootObject_ = [[self loadObject:&position_] retain];
                return rootObject_ != nil;
            }
        }
        return NO;
    }
}

- (BOOL)skipSpaces:(int *)position
{
    while (string_.length > position_) {
        unichar c = [string_ characterAtIndex:*position];
        if (![[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:c]) {
            break;
        }
        ++(*position);
    }
    return *position != string_.length;
}

- (BOOL)skipSpacesAndPunctuation:(int *)position
{
    while (string_.length > position_) {
        unichar c = [string_ characterAtIndex:*position];
        if (![[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:c]
                && ![punctuation_ characterIsMember:c]) {
            break;
        }
        ++(*position);
    }
    return *position != string_.length;
}

- (NSString *)loadSimpleIdentifier:(int *)position
{
    int pos = *position;
    if (![firstIdentifierSymbols_ characterIsMember:[string_ characterAtIndex:pos]]) {
        //NSAssert(NO, @"Error: <%@>", [string_ substringFromIndex:pos]);
        return nil;
    }
    ++pos;
    while (pos < string_.length && [simpleIdentifierSymbols_ characterIsMember:[string_ characterAtIndex:pos]]) {
        ++pos;
    }
    NSString *res = [string_ substringWithRange:(NSRange){*position, pos  - *position}];
    *position = pos;
    return res;
}

- (NUIIdentifier *)loadIdentifier:(int *)position
{
    int pos = *position;
    if (![firstIdentifierSymbols_ characterIsMember:[string_ characterAtIndex:pos]]) {
        //NSAssert(NO, @"Error: <%@>", [string_ substringFromIndex:pos]);
        return nil;
    }
    ++pos;
    while (pos < string_.length && [identifierSymbols_ characterIsMember:[string_ characterAtIndex:pos]]) {
        ++pos;
    }
    NUIIdentifier *identifier = [[[NUIIdentifier alloc] init] autorelease];
    //identifier.range = (NSRange){startPos, position_ - startPos};
    identifier.value = [string_ substringWithRange:(NSRange){*position, pos  - *position}];
    *position = pos;
    return identifier;
}

- (NSString *)loadSystemIdentifier:(int *)position
{
    int pos = *position;
    if ([string_ characterAtIndex:pos] != ':') {
        return nil;
    }
    ++pos;
    while (pos < string_.length && [systemIdentifierSymbols_ characterIsMember:[string_ characterAtIndex:pos]]) {
        ++pos;
    }
    NSString *res = [string_ substringWithRange:(NSRange){*position, pos  - *position}];
    *position = pos;
    return res;
}

- (NSString *)loadString:(int *)position
{
    int pos = *position;
    if ([string_ characterAtIndex:pos] != '\"') {
        return nil;
    }
    ++pos;
    NSString *op = @"\"";
    NSString *op2 = @"\\\"";
    while (YES) {
        NSRange r = [string_ rangeOfString:op options:0 range:(NSRange){pos, string_.length - pos}];
        if (r.length == 0) {
            return nil;
        }

        if (NSOrderedSame != [string_ compare:op2 options:0 range:(NSRange){r.location - op2.length + r.length,
                r.length}]) {
            pos = r.location + r.length;
            NSString *str = [string_ substringWithRange:(NSRange){*position + op.length,
                    pos - *position - 2 * op.length}];
            *position = pos;
            return str;
        }
        pos = r.location + r.length;
    }

    NSAssert(NO, @"Error");
    return nil;
}

- (NUIObject *)loadObject:(int *)position
{
    int pos = *position;
    NSString *op = @"{";
    NSString *type = nil;
    if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] != NSOrderedSame) {
        type = [self loadSimpleIdentifier:&pos];
        if (!type) {
            return nil;
        }
        if (![self skipSpacesAndPunctuation:&pos]) {
            return nil;
        }
        op = @":";
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] != NSOrderedSame) {
            return nil;
        }
        pos += op.length;
        if (![self skipSpacesAndPunctuation:&pos]) {
            return nil;
        }
        op = @"{";
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] != NSOrderedSame) {
            return nil;
        }
    }
    pos += op.length;
    op = @"}";
    NUIObject *object = [[[NUIObject alloc] init] autorelease];
    object.type = type;
    while (YES) {
        if (![self skipSpacesAndPunctuation:&pos]) {
            NSAssert(NO, @"Error");
            return nil;
        }
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
            pos += op.length;
            *position = pos;
            return object;
        }
        NSString *identifier = [self loadSystemIdentifier:&pos];
        if (identifier) {
            if (![self skipSpacesAndPunctuation:&pos]) {
                NSAssert(NO, @"Error");
                return nil;
            }
            NSString *op2 = @"=";
            if ([string_ compare:op2 options:0 range:(NSRange){pos, op.length}] != NSOrderedSame) {
                return nil;
            }
            pos += op2.length;
            if (![self skipSpacesAndPunctuation:&pos]) {
                NSAssert(NO, @"Error");
                return nil;
            }
            id rvalue = [self loadRValue:&pos];
            if (!rvalue) {
                return nil;
            }
            [object.systemProperties setObject:rvalue forKey:identifier];
            continue;
        }
        NUIBinaryOperator *assignment = [self loadAssignment:&pos];
        if (!assignment) {
            NSAssert(NO, @"Error");
            return nil;
        }
        [object.properties addObject:assignment];
    }

    NSAssert(NO, @"Error");
    return nil;
}

- (NSArray *)loadArray:(int *)position
{
    int pos = *position;
    NSString *op = @"[";
    if (![string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
        return nil;
    }
    pos += op.length;
    op = @"]";
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    while (YES) {
        if (![self skipSpacesAndPunctuation:&pos]) {
            NSAssert(NO, @"Error");
            return nil;
        }
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
            pos += op.length;
            *position = pos;
            return array;
        }
        id rvalue = [self loadRValue:&pos];
        if (!rvalue) {
            NSAssert(NO, @"Error");
            return nil;
        }
        [array addObject:rvalue];
    }

    NSAssert(NO, @"Error");
    return nil;
}

- (NUIBinaryOperator *)loadAssignment:(int *)position
{
    int pos = *position;
    id lvalue = [self loadIdentifier:&pos];
    if (!lvalue) {
        return nil;
    }

    if (![self skipSpaces:&pos]) {
        NSAssert(NO, @"Error");
        return nil;
    }
    NUIBinaryOperator *binaryOperator = [[[NUIBinaryOperator alloc] init] autorelease];
    binaryOperator.lvalue = lvalue;
    NSString *op = @"=";
    if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
        binaryOperator.type = NUIBinaryOperatorType_Assignment;
        pos += op.length;
        if (![self skipSpaces:&pos]) {
            NSAssert(NO, @"Error");
            return nil;
        }
        binaryOperator.rvalue = [self loadRValue:&pos];
        if (!binaryOperator.rvalue) {
            NSAssert(NO, @"Error");
            return nil;
        }
        //assignment.range = (NSRange){startPos, pos - *position};
        *position = pos;
        return binaryOperator;
    } else {
        op = @"<=";
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
            binaryOperator.type = NUIBinaryOperatorType_Modification;
            pos += op.length;
            if (![self skipSpaces:&pos]) {
                NSAssert(NO, @"Error");
                return nil;
            }
            binaryOperator.rvalue = [self loadObject:&pos];
            if (!binaryOperator.rvalue) {
                NSAssert(NO, @"Error");
                return nil;
            }
            *position = pos;
            return binaryOperator;
        }
    }
    NSAssert(NO, @"Error");
    return nil;
}

- (NUIBinaryOperator *)loadBinaryOperator:(NSString *)op lvalueLoader:(SEL)lvalueLoader
    rvalueLoader:(SEL)rvalueLoader position:(int *)position
{
    int pos = *position;
    id lvalue = objc_msgSend(self, lvalueLoader, &pos);
    if (!lvalue) {
        return nil;
    }
    if (![self skipSpaces:&pos]) {
        NSAssert(NO, @"Error");
        return nil;
    }
    NUIBinaryOperator *binaryOperator = [[[NUIBinaryOperator alloc] init] autorelease];
    binaryOperator.lvalue = lvalue;
    if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] != NSOrderedSame) {
        return nil;
    }
    pos += op.length;
    if (![self skipSpaces:&pos]) {
        NSAssert(NO, @"Error");
        return nil;
    }
    binaryOperator.rvalue = objc_msgSend(self, rvalueLoader, &pos);
    if (!binaryOperator.rvalue) {
        NSAssert(NO, @"Error");
        return nil;
    }
    *position = pos;
    //assignment.range = (NSRange){startPos, position_ - startPos};
    return binaryOperator;
}

- (id)loadRValue:(int *)position
{
    int pos = *position;
    id res = [self loadString:&pos];
    if (!res) {
        res = [self loadObject:&pos];
    }
    if (!res) {
        res = [self loadArray:&pos];
    }
    if (!res) {
        res = [self loadNumber:&pos];
    }
    if (!res) {
        res = [self loadIdentifier:&pos];
    }
    if (res) {
        *position = pos;
    }
    return res;
}

- (NSNumber *)loadNumber:(int *)position
{
    int pos = *position;
    if (![digits_ characterIsMember:[string_ characterAtIndex:pos]]) {
        return nil;
    }
    ++pos;
    while (pos < string_.length
            && [digits_ characterIsMember:[string_ characterAtIndex:pos]]) {
        ++pos;
    }
    if (pos < string_.length) {
        NSString *op = @".";
        if ([string_ compare:op options:0 range:(NSRange){pos, op.length}] == NSOrderedSame) {
            pos += op.length;
            while (pos < string_.length
                    && [digits_ characterIsMember:[string_ characterAtIndex:pos]]) {
                ++pos;
            }
        }
    }
    NSNumber *num = [NSNumber numberWithDouble:[[string_ substringWithRange:(NSRange){*position, pos - *position}]
            doubleValue]];
    *position = pos;
    return num;
}

@end