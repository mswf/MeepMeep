# UI Documentation

## UI Element
```lua
local uiElement

uiElement.visible = true

-- set to nil or "" to remove
uiElement.tooltip = "tooltip text"

--have this element remove itself from it's parent
uiElement:destroy()
```

## UI Container : UI Element
```lua
local uiContainer

local tree        = uiContainer:addTree( [string "treeText"] )
local textElement = uiContainer:addText( [string "label"],
                                         [int wrapWidth] )
local button      = uiContainer:addButton( [string "buttonText"],
                                           [onPress function() end] )
local inputText   = uiContainer:addInputText( [string "label"],
                                              [string "defaultText"] )
local checkbox    = uiContainer:addCheckbox( [string "label"],
                                             [bool isChecked] )
local slider      = uiContainer:addSlider( string "floats"/"ints")

--remove an element from this Container
uiContainer:remove(element)

--remove all children from this Container
uiContainer:removeChildren()
```

## UI Window : UI Container
```lua
local uiWindow = UiWindow.create()

-- PROPERTIES
-- position
uiWindow.x = 10
uiWindow.y = 10
-- size
uiWindow.height = 400
uiWindow.width = 300

-- title bar
uiWindow.title = "Window Title"
uiWindow.displayTitle = true

-- close and collapse widgets can only be visible
--   if displayTitle == true
uiWindow.closable = true
uiWindow.collapsable = true
uiWindow.collapsed = true

-- show resize widget in the bottom-right corner
uiWindow.resizable = true

-- click and drag anywhere on the window to move it
uiWindow.movable = true

-- CALLBACKS, be careful with upvalues you store in these!!
uiWindow.onClose = function(self) end
uiWindow.onMove = function(self) end
uiWindow.onResize = function(self) end

uiWindow.onExpand = function(self) end
uiWindow.onCollapse = function(self) end

-- FUNCTIONS
-- closes the uiWindow; mind any reference that may be left
uiWindow:close()

```

## Region : UI Container
```lua
local region = uiContainer:addRegion()

-- reset, will be equal to the available width
region.width = 0
-- absolute width
region.width > 0
-- takes up all available space, minus the provided amount
region.width < 0

region.height =

-- show a visible border around the edges
region.bordered = false
```

## Tree : UI Container
```lua
local tree = uiContainer:addTree( [string "treeText"] )

tree.text = "tree Text"
-- Change this from code to manually open and close
tree.opened = true

-- CALLBACKS
checkbox.onExpand = function(self) end
checkbox.onCollapse = function(self) end


```

## Text Element : UI Element
```lua
-- square brackets are used to show optional parameters
local textElement = uiContainer:addText( [string "text"],
                                         [int wrapWidth] )

textElement.text = "Text that is displayed here"

-- reset, will be equal to the available width
textElement.wrapWidth = 0
-- absolute width
textElement.wrapWidth > 0
-- takes up all available space, minus the provided amount
textElement.wrapWidth < 0
```

## Button : UI Element
```lua
local button = uiContainer:addButton( [string "buttonText"],
                                      [onPress function() end] )

button.text = "buttonText"

-- setting width to 0 will make the button resize itself to fit its content
button.width  = 0
button.height = 0

-- CALLBACKS
button.onPress = function(self) end
button.onHoverIn = function(self) end
button.onHoverOut = function(self) end
```

## Input Text : UI Element
```lua
local inputText = uiContainer:addInputText( [string "label"],
                                            [string "defaultText"] )

inputText.label = "label"
inputText.text = "contents"

-- CALLBACKS
inputText.onFocusGain = function(self) end
inputText.onFocusLose = function(self) end
inputText.onChange = function(self) end
```

## Checkbox : UI Element
```lua
local checkbox = uiContainer:addCheckbox( [string "label"],
                                          [bool isChecked] )

checkbox.label = "label"
checkbox.checked = false

-- CALLBACKS
checkbox.onChange = function(self) end
```

## Slider : UI Element
```lua
local slider = uiContainer:addSlider( string "label")

-- %.2f = display the value with 2 decimal points
slider.format = "%.2f cooks" --> 5.00 cooks
slider.label = "labelText"

slider.minValue = 0
slider.maxValue = 10
slider.value = 5
slider.rounded = false -- integer/float

-- CALLBACKS
slider.onChange = function(self) end
```
