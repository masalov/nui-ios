//
//  UILabel+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//
#import <UIKit/UIKit.h>

/*! A category to support loading of properties of \b UILabel from NUI that can't be loaded
 *  automatically.
 */
@interface UILabel (NUILoading)

/*! Allows to load \b textAlignment property using following values:
 *  * \b Left for UITextAlignmentLeft.
 *  * \b Center for UITextAlignmentCenter.
 *  * \b Right for UITextAlignmentRight.
 */
+ (NSDictionary *)nuiConstantsForTextAlignment;
/*! Allows to load \b lineBreakMode property using following values:
 *  * \b WordWrap for UILineBreakModeWordWrap.
 *  * \b CharacterWrap for UILineBreakModeCharacterWrap.
 *  * \b Clip for UILineBreakModeClip.
 *  * \b HeadTruncation for UILineBreakModeHeadTruncation.
 *  * \b TailTruncation for UILineBreakModeTailTruncation.
 *  * \b MiddleTruncation for UILineBreakModeMiddleTruncation.
 */
+ (NSDictionary *)nuiConstantsForLineBreakMode;
/*! Allows to load \b baselineAdjustment property using following values:
 *  * \b None for UIBaselineAdjustmentNone.
 *  * \b AlignBaselines for UIBaselineAdjustmentAlignBaselines.
 *  * \b AlignCenters for UIBaselineAdjustmentAlignCenters.
 */
+ (NSDictionary *)nuiConstantsForBaselineAdjustment;

/*! Allows to use \b localizedText to load localized text into \b text property using
 *  \b NSLocalizedString function.
 */
- (void)setLocalizedText:(NSString *)text;

@end
