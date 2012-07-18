nui-ios
=======

Libraries for simplifying work with UI on iOS

NUILayout
---------

For some reasons there had been no supports for layout til iOS 6. And setting frames in some cases resulted in huge and complicate code.
Besides I prefer to think in terms of stacks and grids, not constraints. This component provides several layouts implementation (grid,
verical and horizonal stack, flow). Besides it allows to create several layouts for one view and swicth between them.

NUILoader
---------

There are many reasons why I don't like to use IB for complex UI: it doesn't allows custom properties, I prefer writing UI than creating
it in GUI tools, etc. This component allows to describe UI in following format:

    self = {
      view <= {
        subviews = [
          view = UILabel:{
            frame = [10, 10, 300, 100]
            autoresizingMask = FlexibleWidth
            text = "AAA"
          }
        ]
      }
    }

