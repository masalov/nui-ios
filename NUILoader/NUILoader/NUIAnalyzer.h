//
//  NUIAnalyzer.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIObject;

@interface NUIAnalyzer : NSObject

@property (nonatomic, readonly) NSArray *imports;
@property (nonatomic, readonly) NSDictionary *constants;
@property (nonatomic, readonly) NSDictionary *styles;
@property (nonatomic, readonly) NSDictionary *states;
@property (nonatomic, readonly) NUIObject *rootObject;

- (id)initWithString:(NSString *)string;

- (BOOL)loadImports;
- (BOOL)loadContentFromMainFile:(BOOL)mainFile;

@end