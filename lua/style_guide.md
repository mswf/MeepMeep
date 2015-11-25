# Coding Style Guide
This is a short written guide on how we are gonna type our code.

### OOP
We all know OOP is sort-of bullshit, but by declaring objects as classes hot-reloading, will become a lot easier.

### Code Standards
NEVER put any game logic inside of UI code. UI may only send and receive data by registering and broadcasting to relevant Broadcasters. Transforming data to display information should be done through static functions inside of the relevant logic classes. Thinks like tooltips and texts should generally only be *formatted* inside of UI code, but its components should be *assembled* by its owners.

***
### Code Conventions

#### Horizontal Space
For this project, configure your editor to always use tabs with 2 chars width. 

#### Classes
Classes are written in UpperCamelCase. Always use ```self``` to name the first parameter of class initialization.
#### Functions
Functions are written in lowerCamelCase. Try use as many static functions as possible. Private functions start with an underscore (```_func()```).
### Values
Values are written in lowerCamelCase. Private functions start with an underscore (```_value```).
Constants are written in UPPERCASE. They should be stored in the class definition. When referencing constants, reference them by using the ```self``` keyword, NOT by referencing the base class by name.

***
### Example
```lua
ExampleClass = class(ExampleClass, function(self, params) --first parameter: "self"
	self.value = params.value or 1
	self.color = params.value or nil
end)

ExampleClass.STRINGCOLORS = {
	blue = Color.blue,
	yellow = Color.yellow
}

function ExampleClass:getValue()
	return self.value
end

function ExampleClass:getDerivativeOfValue()
	return math.abs(self.value)
end

function ExampleClass:setColorByString(stringColor, multiplier)
	self.color = self._stringColorToColor(stringColor) * multiplier
end

-- Use static functions
function ExampleClass._stringColorToColor(stringColor)
	if (stringColor == "grey") then
		return Color.gray
	elseif (stringColor == "pink") then
		return Color.pink
	elseif self.STRINGCOLORS[stringColor] ~= nil then
		return self.STRINGCOLORS[stringColor]
	else
		Log.steb("[ExampleClass] Couldn't parse stringColor: " .. tostring(stringColor))
		return Color.white
	end
end

```
***

## Functionality unique to VroomVroom
You can register a callback for when files are reloaded. Register under the path to the global Broadcaster 'Debug_FileChangedBroadcaster' with a callback that will be called with 2 params; the path + filetype.

### Reserved Functions
The "VroomVroom" engine uses several reserved functions in class definitions. Like Lua metatable keys, these always start with ' __ ' + function.

##### __ engineInit
This function is declared by the baseclass of any classes supplied by the engine to register/initialize itself in the engine.

##### __ onReload
Declaring this function will cause all instances of the class (and those that inherited from it) to have this function called whenever the file with the class definition is hot-reloaded.

***
### Optimization Guide
References:
>http://wiki.luajit.org/Numerical-Computing-Performance-Guide  
>http://www.freelists.org/post/luajit/more-gc-gotchas  
>http://www.freelists.org/post/luajit/FFI-array-performance  

##### Main Take Aways:
Do not call any globals from inside intensive loops. Store a local reference to a global before starting the loop. Store a local reference to any math/util functions in the class declaration.  
Use the string and string pattern library for any messing around with strings. LuaJIT implementation of strings is very fast, so use it.  
When preparing error codes or profiling performance using tags, remember that any concatenation or tostring() calls break many compiler optimizations.


```lua
ExampleClass = class(ExampleClass, function(self)
end)

function ExampleClass:addMarkers(nodes)
	for _, node in ipairs(nodes) do
		local marker = Marker(node)
		marker:setPosition(math.lerp(node.x, 0, 0.5), math.lerp(node.y, 0, 0.5))

		GlobalUI:registerMarker(marker)
	end
end

```

Turns into

```lua
ExampleClass = class(ExampleClass, function(self)
end)

local lerp = math.lerp

function ExampleClass:addMarkers(nodes)
	local uiManager = GlobalUI
	local constructMarker = Marker

	-- ipairs() < pairs < regular for #number
	for _, node in pairs(nodes) do
		local marker = constructMarker(node)
		-- No external "init" functions
		marker.x = lerp(node.x, 0, 0.5)
		marker.y = lerp(node.y, 0, 0.5)

		uiManager:registerMarker(marker)
	end
end

```

***
### UI Documentation

#### UI Element
```lua
local uiElement

uiElement.visible = true

-- set to nil or "" to remove
uiElement.tooltip = "tooltip text"

--have this element remove itself from it's parent
uiElement:destroy()
```

#### UI Container : UI Element
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
```

#### UI Window : UI Container
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

#### Region : UI Container
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

#### Tree : UI Container
```lua
local tree = uiContainer:addTree( [string "treeText"] )

tree.text = "tree Text"
-- Change this from code to manually open and close
tree.opened = true

-- CALLBACKS
checkbox.onExpand = function(self) end
checkbox.onCollapse = function(self) end


```

#### Text Element : UI Element
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

#### Button : UI Element
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

#### Input Text : UI Element
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

#### Checkbox : UI Element
```lua
local checkbox = uiContainer:addCheckbox( [string "label"],
                                          [bool isChecked] )

checkbox.label = "label"
checkbox.checked = false

-- CALLBACKS
checkbox.onChange = function(self) end
```

#### Slider : UI Element
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
