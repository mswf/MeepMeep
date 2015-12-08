##BaseEntity

To use entities one should extend the `Engine.baseEntity` class, and create new instances of that extension.
Since the `Engine.baseEntity` has a `__engineInit` function, extending it and creating the instance will create an entity in the Engine itself.

#### addChild
```lua
	BaseEntity:addChild(child)
```
* `child` BaseEntity  
Adds a child to this entity. Entities' transform values are relative to their parent's.

#### addComponent
```lua
	BaseEntity:addComponent(component)
```
* `component` [BaseComponent]  
Adds any of the base components to this entity. The following are currently valid base components:
* [Engine.baseMeshRenderer](meshRenderer.md)
* [Engine.baseDebugRenderer](debugRenderer.md)  
Once added, the component can be accessed through the entity i.e. `someEntity.meshRenderer`

#### getX
```lua
	BaseEntity:getX()
```
Returns the x value of the entity's transform

#### getY
```lua
	BaseEntity:getY()
```
Returns the y value of the entity's transform

#### getZ
```lua
	BaseEntity:getZ()
```
Returns the z value of the entity's transform

#### getScaleX
```lua
	BaseEntity:getScaleX()
```
Returns the ScaleX value of the entity's transform

#### getScaleY
```lua
	BaseEntity:getScaleY()
```
Returns the ScaleY value of the entity's transform

#### getScaleZ
```lua
	BaseEntity:getScaleZ()
```
Returns the ScaleZ value of the entity's transform

#### getPitch
```lua
	BaseEntity:getPitch()
```
Returns the Pitch value of the entity's transform

#### getYaw
```lua
	BaseEntity:getYaw()
```
Returns the Yaw value of the entity's transform

#### getRoll
```lua
	BaseEntity:getRoll()
```
Returns the Roll value of the entity's transform

#### getPosition
```lua
	BaseEntity:getPosition()
```
Returns the Position of the entity's transform as x,y,z

#### getScale
```lua
	BaseEntity:getScale()
```
Returns the Scale of the entity's transform as x,y,z

#### getRotation
```lua
	BaseEntity:getRotation()
```
Returns the Rotation of the entity's transform as [?]

#### setX
```lua
	BaseEntity:setX(x)
```
* `x`  
Sets the x value of the entity's transform

#### setY
```lua
	BaseEntity:setY(y)
```
* `y`  
Sets the y value of the entity's transform

#### setZ
```lua
	BaseEntity:setZ(z)
```
* `z`  
Sets the z value of the entity's transform

#### setScaleX
```lua
	BaseEntity:setScaleX(scale)
```
* `scale`  
Sets the scaleX value of the entity's transform

#### setScaleY
```lua
	BaseEntity:setScaleY(scale)
```
* `scale`  
Sets the scaleY value of the entity's transform

#### setScaleZ
```lua
	BaseEntity:setScaleZ(scale)
```
* `scale`  
Sets the scaleZ value of the entity's transform

#### setPitch
```lua
	BaseEntity:setPitch(pitch)
```
* `pitch`  
Sets the Pitch value of the entity's transform

#### setYaw
```lua
	BaseEntity:setYaw(yaw)
```
* `yaw`  
Sets the Yaw value of the entity's transform

#### setRoll
```lua
	BaseEntity:setRoll(roll)
```
* `roll`  
Sets the Roll value of the entity's transform

#### setPosition
```lua
	BaseEntity:setPosition(x,y,z)
```
* `x`
* `y`
* `z`  
Sets the position of the entity's transform to x,y,z

#### setScale
```lua
	BaseEntity:setScale(x,y,z)
```
* `x`
* `y`
* `z`  
Sets the scale of the entity's transform to x,y,z

#### setRotation
```lua
	BaseEntity:setRotation(?,?,?)
```
* `?`
* `?`
* `?`  
Sets the rotation of the entity's transform to ?,?,?

#### addX
```lua
	BaseEntity:addX(dx)
```
* `dx`  
Add dx to the x position of the entity's transform

#### addY
```lua
	BaseEntity:addY(dy)
```
* `dy`  
Add dy to the y position of the entity's transform

#### addZ
```lua
	BaseEntity:addZ(dz)
```
* `dz`  
Add dz to the z position of the entity's transform

#### addScaleX
```lua
	BaseEntity:addScaleX(dx)
```
* `dx`  
Add dx to the x scale of the entity's transform

#### addScaleY
```lua
	BaseEntity:addScaleY(dy)
```
* `dy`  
Add dy to the y scale of the entity's transform

#### addScaleZ
```lua
	BaseEntity:addScaleZ(dz)
```
* `dz`  
Add dz to the z scale of the entity's transform

#### pitch
```lua
	BaseEntity:pitch(?)
```
* `?`  
pitch the entity's transform by ?

#### yaw
```lua
	BaseEntity:yaw(?)
```
* `?`  
yaw the entity's transform by ?

#### roll
```lua
	BaseEntity:roll(?)
```
* `?`  
roll the entity's transform by ?
