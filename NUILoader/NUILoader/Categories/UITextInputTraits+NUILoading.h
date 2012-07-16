//
//  UITextInputTraits+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import <UIKit/UIKit.h>

#if defined __cplusplus
extern "C" {
#endif

BOOL autocapitalizationTypeFromNUIValue(UITextAutocapitalizationType *autocapitalizationType,
                                        NSString *value);
BOOL autocorrectionTypeFromNUIValue(UITextAutocorrectionType *autocorrectionType, NSString *value);
BOOL keyboardTypeFromNUIValue(UIKeyboardType *keyboardType, NSString *value);

#if defined __cplusplus
};
#endif