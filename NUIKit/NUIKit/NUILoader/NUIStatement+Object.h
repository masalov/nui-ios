//
//  NUIStatement+Object.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUIStatement.h"

@class NUIError;

@interface NUIStatement (Object)

- (NSMutableDictionary *)systemProperties;
- (NSMutableArray *)properties;
- (id)property:(NSString *)property ofClass:(Class)class error:(NUIError **)error;

@end
