//
//  NUIStatement+Object.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUIStatement.h"

@interface NUIStatement (Object)

- (NSMutableDictionary *)systemProperties;
- (NSMutableArray *)properties;
- (id)property:(NSString *)property ofClass:(Class)class;

@end
