##BaseMaterial

To use materials one should extend the `Engine.baseMaterial` class, and create new instances of that extension.
Since the `Engine.baseMaterial` has a `__engineInit` function, extending it and creating the instance will create a material in the Engine itself.

Alternative, a material that has been imported can be gained through Engine.getMaterial()

#### getMaterial
```lua
	Engine.getMaterial(name)
```
* `name` String  
Gets a material from the resource manager with the name name, provided it has been imported already

#### setShader
! Not implemented !

#### setDiffuseTexture
```lua
	baseMaterial:setDiffuseTexture(path)
```
* `path` String  
Sets the materials diffuse texture to the texture at the path. The texture has to be imported already

#### setSpecularTexture
```lua
	baseMaterial:setSpecularTexture(path)
```
* `path` String  
Sets the materials specular texture to the texture at the path. The texture has to be imported already

#### setNormalTexture
```lua
	baseMaterial:setNormalTexture(path)
```
* `path` String  
Sets the materials normal texture to the texture at the path. The texture has to be imported already

#### setCubeMapTexture
```lua
	baseMaterial:setCubeMapTexture(path)
```
* `path` String  
Sets the materials cube map texture to the texture at the path. The texture has to be imported already

#### setHeightMapTexture
```lua
	baseMaterial:setHeightMapTexture(path)
```
* `path` String  
Sets the materials height map texture to the texture at the path. The texture has to be imported already

#### setDrawingWireframe
```lua
	baseMaterial:setDrawingWireframe(drawing)
```
* `drawing` Boolean  
Sets the material's wireframe on or off

#### setTwoSided
```lua
	baseMaterial:setTwoSided(twoSided)
```
* `twoSided` Boolean  
Sets the material's two sided drawing on or off

#### setShininess
```lua
	baseMaterial:setShininess(shininess)
```
* `shininess` Float  
Sets the material's "shininess"

#### setShininessStrength
```lua
	baseMaterial:setShininessStrength(strength)
```
* `strength` Float  
Sets the material's "shininess strength"

#### setOpacity
```lua
	baseMaterial:setOpacity(opacity)
```
* `opacity` Float  
Sets the material's opacity

#### setBumpScaling
```lua
	baseMaterial:setBumpScaling(scaling)
```
* `scaling` Float  
Sets the scaling of the material's bumps (as in, bumpmap)

#### setAmbientColor
```lua
	baseMaterial:setAmbientColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the ambient color of the material

#### setDiffuseColor
```lua
	baseMaterial:setDiffuseColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the diffuse color of the material

#### setSpecularColor
```lua
	baseMaterial:setSpecularColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the specular color of the material

#### setEmissiveColor
```lua
	baseMaterial:setEmissiveColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the emissive color of the material

#### setTransparentColor
```lua
	baseMaterial:setTransparentColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the transparent color of the material

#### setReflectiveColor
```lua
	baseMaterial:setReflectiveColor(r, g, b, a)
```
* `r` Float [0 - 1]
* `g` Float [0 - 1]
* `b` Float [0 - 1]
* `a` Float [0 - 1]  
Sets the reflective color of the material

#### getDrawingWireframe
```lua
	baseMaterial:getDrawingWireframe()
```
returns wether the material is in wireframe drawing mode

#### getTwoSided
```lua
	baseMaterial:getTwoSided()
```
returns wether the material is drawing two sided

#### getShininess
```lua
	baseMaterial:getShininess()
```
returns the shininess of the material

#### getShininessStrength
```lua
	baseMaterial:getShininessStrength()
```
returns the material's "shininess strength"

#### getOpacity
```lua
	baseMaterial:getOpacity()
```
gets the material's opacity

#### getBumpScaling
```lua
	baseMaterial:getBumpScaling()
```
gets the scaling of the material's bumps (as in, bumpmap)

#### getAmbientColor
```lua
	baseMaterial:getAmbientColor()
```
gets the ambient color of the material as r, g, b, a

#### getDiffuseColor
```lua
	baseMaterial:getDiffuseColor()
```
gets the diffuse color of the material as r, g, b, a

#### getSpecularColor
```lua
	baseMaterial:getSpecularColor()
```
gets the specular color of the material as r, g, b, a

#### getEmissiveColor
```lua
	baseMaterial:getEmissiveColor()
```
gets the emissive color of the material as r, g, b, a

#### getTransparentColor
```lua
	baseMaterial:getTransparentColor()
```
gets the transparent color of the material as r, g, b, a

#### getReflectiveColor
```lua
	baseMaterial:getReflectiveColor()
```
gets the reflective color of the material as r, g, b, a
