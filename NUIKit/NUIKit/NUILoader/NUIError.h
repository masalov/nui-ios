//
//  NUIError.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIData;
@class NUIStatement;

@interface NUIError : NSObject

@property (nonatomic, strong) NUIData *data;
@property (nonatomic, unsafe_unretained) int position;
@property (nonatomic, copy) NSString *message;

- (id)initWithData:(NUIData *)data position:(int)position message:(NSString *)message;
- (id)initWithStatement:(NUIStatement *)statement message:(NSString *)message;

+ (id)errorWithData:(NUIData *)data position:(int)position message:(NSString *)message;
+ (id)errorWithStatement:(NUIStatement *)statement message:(NSString *)message;

@end
