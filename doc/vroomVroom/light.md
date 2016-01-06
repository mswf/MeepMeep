##BaseLight

To use lights one should extend the `Engine.baseLight` class, and create new instances of that extension.
Since the `Engine.baseLight` has a `__engineInit` function, extending it and creating the instance will create a light in the Engine itself.

A light must be added to an entity to make it appear in the game

!NOTE! At the moment, there can only be one directional light in the game

#### setType
```lua
	Engine:setType(type)
```
* `type` String  
_currently not implemented_

#### setIntensity
```lua
	baseCamera:setIntensity(intensity)
```
* `intensity` Number  
Sets the light's 'intensity' to the provided value

#### setColor
```lua
	baseCamera:setColor(r, g, b, a)
```
* `ratio` Float
Sets the light's color to the provided value

#### setFOV
```lua
	baseCamera:setFOV(fov)
```
* `fov` Float   
Sets the camera's Field Of Vision

#### setNearPlaneDistance
```lua
	baseCamera:setNearPlaneDistance(dist)
```
* `dist` Float   
Sets the camera's near plane distance. value must be > 0

#### setFarPlaneDistance
```lua
	baseCamera:setFarPlaneDistance(dist)
```
* `dist` Float  
Sets the camera's far plane distance. value must be > 0

#### makeActive
```lua
	baseCamera:makeActive()
```
Makes this the active camera
