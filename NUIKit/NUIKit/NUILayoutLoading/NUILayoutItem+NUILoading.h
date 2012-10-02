#import "NUILayoutItem.h"

/*! A category to support loading of properties of \b NUILayoutItem from NUI that can't be loaded
 *  automatically.
 */
@interface NUILayoutItem (NUILoading)

/*! Allows to load \b horizontalAlignment property using following values:
 *  * \b Left for \b NUIHorizontalAlignment_Left.
 *  * \b Stretch for \b NUIHorizontalAlignment_Stretch.
 *  * \b Center for \b NUIHorizontalAlignment_Center.
 *  * \b Right for \b NUIHorizontalAlignment_Right.
 */
+ (NSDictionary *)nuiConstantsForHorizontalAlignment;
/*! Allows to load \b verticalAlignment property using following values:
 *  * \b Top for \b NUIVerticalAlignment_Top.
 *  * \b Stretch for \b NUIVerticalAlignment_Stretch.
 *  * \b Center for \b NUIVerticalAlignment_Center.
 *  * \b Bottom for \b NUIVerticalAlignment_Bottom.
 */
+ (NSDictionary *)nuiConstantsForVerticalAlignment;
/*! Allows to load \b visibility property using following values:
 *  * \b Hidden for \b NUIVisibility_Hidden.
 *  * \b Collapsed for \b NUIVisibility_Collapsed.
 *  * \b Visible for \b NUIVisibility_Visible.
 */
+ (NSDictionary *)nuiConstantsForVisibility;

@end
