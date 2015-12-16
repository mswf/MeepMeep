##BaseDebugRenderer

To use debugRenderers one should extend the `Engine.baseDebugRenderer` class, and create new instances of that extension.
Since the `Engine.baseDebugRenderer` has a `__engineInit` function, extending it and creating the instance will create a debugRenderer in the Engine itself.

A debug renderer can be added to an entity to make it appear in the game

!NOTE! At the moment, when creating a renderer, it MUST be attached to an entity or the engine will crash

#### addLine
```lua
	baseDebugRenderer:addLine(x1, y1, z1, x2, y2, z2, r, g, b, a)
```
* `x1` Float
* `y1` Float
* `z1` Float

* `x2` Float
* `y2` Float
* `z2` Float

* `r` Float
* `g` Float
* `b` Float
* `a` Float

Adds a line to the renderer from <x1,y1,z1> to <x2,y2,z2> with the color (r,g,b,a)
Note: once adding lines, you should not at any triangles

#### addLine
```lua
	baseDebugRenderer:addLine(x1, y1, z1, x2, y2, z2, x3, y3, z3, r, g, b, a)
```
* `x1` Float
* `y1` Float
* `z1` Float

* `x2` Float
* `y2` Float
* `z2` Float

* `x3` Float
* `y3` Float
* `z3` Float

* `r` Float
* `g` Float
* `b` Float
* `a` Float

Adds a line to the renderer from <x1,y1,z1> to <x2,y2,z2> to <x3,y3,z3> with the color (r,g,b,a)
Note: once adding triangles, you should not at any lines


#### setDrawPoints
```lua
	baseDebugRenderer:setDrawPoints(isDrawing)
```
* `isDrawing` bool = false

Draw points at the start and end of every line.

#### setPointSize
```lua
	baseDebugRenderer:setDrawPoints(size)
```
* `size` float = 5.0

The size of the points drawn at the start and end of every line.

#### clear
```lua
	baseDebugRenderer:clear()
```
Clears the renderer
