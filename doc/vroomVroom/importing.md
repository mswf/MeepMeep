##Importing

Assets have to be imported into memory before they can be used.

#### importModel
```lua
	Engine.importModel(path)
```
* `path` String  
Imports the model (obj) at path. Any materials defined the model will also be imported (confirm with tinas)?

#### importTexture
```lua
	Engine.importTexture(path, [flipped])
```
* `path` String  
* `flipped` Boolean, def. false  
Imports the texture at path.

#### reloadTexture
```lua
	Engine.reloadTexture(path, [flipped])
```
* `path` String  
* `flipped` Boolean, def. false  
Reloads the texture at path.

#### reloadShader
```lua
	Engine.reloadShader(path, type)
```
* `path` String  
* `type` String - ShaderType [VERTEX, GEOMETRY, FRAGMENT, TESS_CONTROL, TESS_EVALUATION]
Reloads the shader at path.

#### isModelLoaded
```lua
	Engine.isModelLoaded(path)
```
* `path` String  
Returns wether the model at the given path is loaded

#### isTextureLoaded
```lua
	Engine.isTextureLoaded(path)
```
* `path` String  
Returns wether the texture at the given path is loaded

#### isMaterialLoaded
```lua
	Engine.isMaterialLoaded(path)
```
* `path` String  
Returns wether the material at the given path is loaded

#### isShaderLoaded
```lua
	Engine.isShaderLoaded(path)
```
* `path` String  
Returns wether the shader at the given path is loaded
