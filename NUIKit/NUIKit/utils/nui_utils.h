//
//  nui_utils.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/4/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif

NSString *propertyClassName(Class cl, NSString *propertyName);

BOOL isSuperClass(Class cl, Class superCl);

#if defined __cplusplus
};
#endif