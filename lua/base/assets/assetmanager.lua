


ShaderTypes = {
	VERTEX = "VERTEX",
	GEOMETRY = "GEOMETRY",
	FRAGMENT = "FRAGMENT",
	TESS_CONTROL = "TESS_CONTROL",
	TESS_EVALUATION = "TESS_EVALUATION",
}

AssetManager = class(AssetManager, function(self)
	self._importedShaders = {}

	self._importedTextures = {}
	self._importedModels = {}
end)

function AssetManager:importShader(path, shaderType)
	if (not self._importedShaders[path]) then
		if (Engine.importShader(path, shaderType)) then
			self._importedShaders[path] = {
				shaderType = shaderType
				-- TODO: debug information also?
			}
		else
			Log.warning("[AssetLoader] shader import failed: " .. tostring(path))
		end
	else
		Log.warning("[AssetLoader] tried to re-import shader at path: " .. tostring(path))
	end
end

function AssetManager:importTexture(path)
	if (not self._importedTextures[path]) then
		if (Engine.importTexture(path)) then
			self._importedTextures[path] = {
				-- TODO: debug information also?
			}
		else
			Log.warning("[AssetLoader] texture import failed: " .. tostring(path))
		end
	else
		Log.warning("[AssetLoader] tried to re-import shader at path: " .. tostring(path))
	end
end

function AssetManager:importModel(path, scale)
	if (not self._importedModels[path]) then
		if (Engine.importTexture(path)) then
			self._importedModels[path] = {
				scale = scale
				-- TODO: debug information also?
			}
		else
			Log.warning("[AssetLoader] model import failed: " .. tostring(path))
		end
	else
		Log.warning("[AssetLoader] tried to re-import shader at path: " .. tostring(path))
	end
end


function AssetManager:reloadShader(path)
	Log.steb("Trying to reload shader at path: "..path)
	if (Engine.isShaderLoaded(path .. ".glsl")) then
		Log.error("[AssetLoader] TODO: reload shader")
		Engine.reloadShader(path .. ".glsl")
	end
end

function AssetManager:reloadTexture(path)
	if (self._importedTextures[path]) then
		Log.error("[AssetLoader] TODO: reload asset")
	end
end

function AssetManager:reloadModel(path)
	if (self._importedModels[path]) then
		Log.error("[AssetLoader] TODO: reload asset")
	end
end
