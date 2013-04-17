//
//  UIControl+NUILoading.h
//  NUILoader
//
//  Created by Ivan Masalov on 7/12/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUIStatement;
@class NUILoader;
@class NUIError;

/*! A category to support loading of properties of \b UIControl from NUI that can't be loaded
 *  automatically.
 */
@interface UIControl (NUILoading)

/*! Allows to load \b contentVerticalAlignment property using following values:
 *  * \b Center for \b UIControlContentVerticalAlignmentCenter.
 *  * \b Top for \b UIControlContentVerticalAlignmentTop.
 *  * \b Bottom for \b UIControlContentVerticalAlignmentBottom.
 *  * \b Fill for \b UIControlContentVerticalAlignmentFill.
 */
+ (NSDictionary *)nuiConstantsForContentVerticalAlignment;
/*! Allows to load \b contentHorizontalAlignment property using following values:
 *  * \b Center for \b UIControlContentHorizontalAlignmentCenter.
 *  * \b Left for \b UIControlContentHorizontalAlignmentLeft.
 *  * \b Right for \b UIControlContentHorizontalAlignmentRight.
 *  * \b Fill for \b UIControlContentHorizontalAlignmentFill.
 */
+ (NSDictionary *)nuiConstantsForContentHorizontalAlignment;

/*! Loads \b UIControlEvents from NUI using following values:
 *  * \b TouchDown for \b UIControlEventTouchDown.
 *  * \b TouchDownRepeat for \b UIControlEventTouchDownRepeat.
 *  * \b TouchDragInside for \b UIControlEventTouchDragInside.
 *  * \b TouchDragOutside for \b UIControlEventTouchDragOutside.
 *  * \b TouchDragEnter for \b UIControlEventTouchDragEnter.
 *  * \b TouchDragExit for \b UIControlEventTouchDragExit.
 *  * \b TouchUpInside for \b UIControlEventTouchUpInside.
 *  * \b TouchUpOutside for \b UIControlEventTouchUpOutside.
 *  * \b TouchCancel for \b UIControlEventTouchCancel.
 *  * \b ValueChanged for \b UIControlEventValueChanged.
 *  * \b EditingDidBegin for \b UIControlEventEditingDidBegin.
 *  * \b EditingChanged for \b UIControlEventEditingChanged.
 *  * \b EditingDidEnd for \b UIControlEventEditingDidEnd.
 *  * \b EditingDidEndOnExit for \b UIControlEventEditingDidEndOnExit.
 */
- (BOOL)controlEvent:(UIControlEvents *)event fromNUIValue:(NSString *)value;
/*! Loads a subscription to an event from NUI. The following properties are can be used:
 *  * \b event - an event type.
 *  * \b selector - a string with selector signature.
 *  * \b target - an object identifier (optional, root object is used by default).
 */
- (BOOL)loadNUIActionFromRValue:(NUIStatement *)value loader:(NUILoader *)loader
    error:(NUIError **)error;

@end
