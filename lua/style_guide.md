# Coding Style Guide
This is a short written guide on how we are gonna type our code.

### OOP
We all know OOP is sort-of bullshit, but by declaring objects as classes hot-reloading, will become a lot easier.

***
### Code Conventions
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
