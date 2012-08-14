//
//  NUIAnalyzer.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIData;
@class NUIStatement;
@class NUIError;

@interface NUIAnalyzer : NSObject

@property (nonatomic, readonly) NSArray *imports;
@property (nonatomic, readonly) NSDictionary *constants;
@property (nonatomic, readonly) NSDictionary *styles;
@property (nonatomic, readonly) NSDictionary *states;
@property (nonatomic, readonly) NUIStatement *rootObject;
@property (nonatomic, retain, readonly) NUIError *lastError;

- (id)initWithData:(NUIData *)data;

- (BOOL)loadImports;
- (BOOL)loadContentFromMainFile:(BOOL)mainFile;

@end