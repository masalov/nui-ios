//
//  NUIError.h
//  NUIKit
//
//  Created by Ivan Masalov on 8/9/12.
//  Copyright (c) 2012 Ivan Masalov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIData;

@interface NUIError : NSObject

@property (nonatomic, retain) NUIData *data;
@property (nonatomic, assign) int position;
@property (nonatomic, copy) NSString *message;

- (id)initWithData:(NUIData *)data position:(int)position message:(NSString *)message;

+ (id)errorWithData:(NUIData *)data position:(int)position message:(NSString *)message;

@end
