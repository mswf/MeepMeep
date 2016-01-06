##BaseCamera

To use cameras one should extend the `Engine.baseCamera` class, and create new instances of that extension.
Since the `Engine.baseCamera` has a `__engineInit` function, extending it and creating the instance will create a camera in the Engine itself.

A camera can be added to an entity to make it appear in the game

!NOTE! At the moment, if there is no active camera in the game it will crash

#### getActiveCamera
```lua
	Engine:getAciveCamera()
```
Gets the entity that holds the active camera (_should be changed in the future to give the actual camera component_)

#### setProjectionType
```lua
	baseCamera:setProjectionType(type)
```
* `type` String  
Sets the camera's projection type to either 'orthographic' or 'perspective'

#### setAspectRatio
```lua
	baseCamera:setAspectRatio(ratio)
```
* `r` Float
* `g` Float
* `b` Float
* `a` Float  
Sets the camera's aspect ratio to a a value of <0,1]

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
