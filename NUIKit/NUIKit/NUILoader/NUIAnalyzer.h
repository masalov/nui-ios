//
//  NUIAnalyzer.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/3/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIData;
@class NUIStatement;
@class NUIError;

@interface NUIAnalyzer : NSObject

@property (nonatomic, strong, readonly) NSArray *imports;
@property (nonatomic, strong, readonly) NSDictionary *constants;
@property (nonatomic, strong, readonly) NSDictionary *styles;
@property (nonatomic, strong, readonly) NSDictionary *states;
@property (nonatomic, strong, readonly) NUIStatement *mainAssignment;
@property (nonatomic, strong, readonly) NUIError *lastError;

- (id)initWithData:(NUIData *)data;

- (BOOL)loadImports;
- (BOOL)loadContentFromMainFile:(BOOL)mainFile;

@end