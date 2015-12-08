##BaseMeshRenderer

To use meshRenderers one should extend the `Engine.baseMeshRenderer` class, and create new instances of that extension.
Since the `Engine.baseMeshRenderer` has a `__engineInit` function, extending it and creating the instance will create a meshrenderer in the Engine itself.

A mesh renderer can be added to an entity to make it appear in the game

!NOTE! At the moment, when creating a renderer, it MUST be attached to an entity or the engine will crash

#### setModel
```lua
	baseMeshRenderer:setModel(model)
```
* `model` Model
Sets the model that should be renderered by this meshrenderer

#### setMaterial
```lua
	baseMeshRenderer:setMaterial(material)
```
* `material` Material
Sets the material that should be used to render this meshrenderer's model
