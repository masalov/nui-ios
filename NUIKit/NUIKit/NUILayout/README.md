NUILayout
=========

This component allows to simplify management of views layout.

Usage
-----

UIView class has layoutSubviews method where all layouting should happen and the simplest approach is to
create UIView subclass for each kind of layouting. The drawback of such approach is becoming obvious when
several layouts are needed (i.e. for different orientations): we have several main view that should share
subviews. One of the solutions is to extract layouting to separate class.

NUILayout is a base class for all layouts. This class just stores pairs of UIView and NUILayoutItem objects.
NUILayoutItem class stores layout attributes of a view and was create for the same reason as NUILayout to
allow existence of several layouts.

So to use layouts you need to create NUILayoutView:

    NUILayoutView *view = [[NUILayoutView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

Create subclass of NUILayout:

    NUIVerticalLayout *layout = [[NUIVerticalLayout alloc] init];

Following layouts are implemented:

* NUIHorizontalLayout - layouts subviews horizontally one after another.
* NUIVerticalLayout - layouts subview vertically one after another.
* NUIFlowLayout - layouts subviews in line from left to right and from top to bottom.
* NUIGridLayout - layouts subviews in grid where each subview can take several cells.

NUIGridLayout is most complex of them and its provides its own methods for adding subviews.

Create some subviews:
   
    UIButton *button = [[UIButton alloc] init];
    NUILayoutItem *item = [layout addSubview:button];
    item.fixedSize = CGSizeMake(330, 40);

Properties of UIView (such as frame) shouldn't be used directly. Instead NUILayoutItem provides properties for:

* Minimum, maximum and fixed sizes.
* Vertical and horizontal alignments.
* Margin.
* Visibility.

NUIGridLayoutItem provides several properties for changing column and row ranges.

Set layout property of NUILayoutView:

    view.layout = layout;

This can be done before or after configuring layout, because any changes in layout items or adding/removing subviews
will cause in scheduling relayouting. On changing layout all subview from old layouts are removed and all subviews
from new layout are added, so you need only one line of code to changed layout. If you need animation on relayouting
set layoutAnimation property of NUILayoutView. First layouting is always performed without animation.

Implementing custom layout
--------------------------

To implement your custom layout you need to subclass NUILayout and implement layoutForSize and preferredSizeThatFits.
Also you need override createLayoutItem if custom layout item is needed.

Autosize
--------

There are two main reasons for layouts: rotations and layouting basing on subviews content size. To support automatizing
UIView subclass should override preferredSizeThatFits from NUILayout category of UIView and set needsToUpdateSize
property of the same category to YES on preferred size changes. By default preferredSizeThatFits returns CGSizeZero
that is more reasonable than the current frame returned by sizeThatFits method. See NUILabel for details of
implementation.

In addition there is NUIScrollView. It is scrollview that has only one subview and corresponding layout item and
calculates content size automatically.
