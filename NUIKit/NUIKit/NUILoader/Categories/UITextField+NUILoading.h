//
//  UITextField+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! A category to support loading of properties of \b UITextField from NUI that can't be loaded
 *  automatically.
 */
@interface UITextField (NUILoading)

/*! Allows to load \b autocapitalizationType property using following values:
 *  * \b None for \b UITextAutocapitalizationTypeNone.
 *  * \b Sentences for \b UITextAutocapitalizationTypeSentences.
 *  * \b Words for \b UITextAutocapitalizationTypeWords.
 *  * \b AllCharacters for \b UITextAutocapitalizationTypeAllCharacters.
 */
+ (NSDictionary *)nuiConstantsForAutocapitalizationType;
/*! Allows to load \b autocorrectionType property using following values:
 *  * \b No for \b UITextAutocorrectionTypeNo.
 *  * \b Yes for \b UITextAutocorrectionTypeYes.
 *  * \b Default for \b UITextAutocorrectionTypeDefault.
 */
+ (NSDictionary *)nuiConstantsForAutocorrectionType;
/*! Allows to load \b keyboardType property using following values:
 *  * \b Default for \b UIKeyboardTypeDefault.
 *  * \b ASCIICapable for \b UIKeyboardTypeASCIICapable.
 *  * \b NumbersAndPunctuation for \b UIKeyboardTypeNumbersAndPunctuation.
 *  * \b URL for \b UIKeyboardTypeURL.
 *  * \b NumberPad for \b UIKeyboardTypeNumberPad.
 *  * \b PhonePad for \b UIKeyboardTypePhonePad.
 *  * \b NamePhonePad for \b UIKeyboardTypeNamePhonePad.
 *  * \b EmailAddress for \b UIKeyboardTypeEmailAddress.
 *  * \b DecimalPad for \b UIKeyboardTypeDecimalPad* (available in iOS 4.1 and later).
 *  * \b Twitter for \b UIKeyboardTypeTwitter* (available in iOS 5.0 and later).
 */
+ (NSDictionary *)nuiConstantsForKeyboardType;

/*! Allows to use \b localizedText to load localized text into \b text property using
 *  \b NSLocalizedString function.
 */
- (void)setLocalizedText:(NSString *)text;
/*! Allows to use \b localizedPlaceholder to load localized text into *placeholder* property using
 *  \b NSLocalizedString function.
 */
- (void)setLocalizedPlaceholder:(NSString *)placeholder;

@end
