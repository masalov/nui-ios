NUILoader
=========

This component allows to load UI from NUI files.

Blocks
------

NUI files consist of blocks that are similar to JSON excepting there are almost no quotes and punctuation
is optional. There following blocks:

* Strings: "The string".
* Numbers: 5.5.
* Identifiers: myLabel.text.
* Arrays: ["Object 1" "Object2" "Object 3"].
* Objects.

Objects consist of two parts enclosed in {}:

* System properties.
* Properties assignments
* Properties modifications.

There are system properties:

* :class - allows to set object class, if not set class that was specified in property declaration is used.
* :id - place the object to the dictionary of global objects with the value as a key.
* :property - sets root object property with a name as the value to the object.
* :style - loads an style.

Property assignment is written as:

    property_key_path = rvalue

RValue can be any block and if it is an identifier the first part of it is used to get an object from the
dictionary of global objects and the rest is used as key path to get property value.

Property modification is written as:

    view1.subview1 <= {
        frame = [0, 0, 100, 100]
        backgroundColor = "AA0000"
    }

And it is the same as:

    view1.subview1.frame = [0, 0, 100, 100]
    view1.subview1.backgroundColor = "AA0000"

Sections
--------

NUI files consist of the following sections:

* Imports.
* Constants.
* Styles.
* States.
* Root object definition.

Imports allow to include other files:

    import "styles.nui"

These file can contain imports, constants and styles only.

Constants allow to define objects that are created only if they are used, i.e. we can define all possible fonts
in a separate file and UIFont objects will be created only for those that are really needed. Constants are
defined as follows:

    const my_font = {
        :class = UIFont
        size = 12
    }
    const width = 10

Styles allows to extract common properties and describe them once:

    style label_style = {
        font = my_font
        textColor = "00FF00"
    }
    ...
    label1 = {
        :style = my_style
        text = "Label 1"
    }
    ...
    label2 = {
        :style = my_style
        text = "Label 2"
    }

State is a list of assignments that can be applied in future:

    state hidden = {
        textView.hidden = YES
        button.title = "Show"
    }

Root object definition:

    root = {
        ....
    }

Root object is placed in the global objects dictionary with "root" key.

Using from code
---------------

Loading NUI file is quite simple:

    NUILoader *loader = [[NUILoader alloc] initWithRootObject:self];
    BOOL res = [loader loadFromFile:@"nui.nui"]; 

All errors are written to output log.

Loading of a state is done in one line of code:

    [loader loadState:@"hidden"];

In addition all properties (if they are not of a primitive type) of root object that
were set by NUILoader can be set to nil with the following code:

    [loader resetRootObjectProperties];
