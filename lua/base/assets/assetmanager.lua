


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

	self.broadcaster = Broadcaster()
end)

function AssetManager:importShader(path, shaderType)
	if (not self._importedShaders[path]) then
		if (Engine.importShader(path, shaderType)) then
			self._importedShaders[path] = {
				shaderType = shaderType
				-- #TODO:0 debug information also?
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
				-- #TODO:10 debug information also?
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
		if (Engine.importModel(path)) then
			self._importedModels[path] = {
				scale = scale
				-- #TODO:20 debug information also?
			}
		else
			Log.warning("[AssetLoader] model import failed: " .. tostring(path))
		end
	else
		Log.warning("[AssetLoader] tried to re-import shader at path: " .. tostring(path))
	end
end

function AssetManager:onFileChanged(fullPath)
	local path = fullPath
	local type = nil

	do
		local stringLength = string.len(path)

		dotPosition  = string.find(path, "%.")

		type = string.sub(path, dotPosition+1)
		path = string.sub(path, 1, dotPosition-1)

		-- Windows path fixing step
		path = string.gsub(path, "\\", "/")

		-- Mac returns the full filepath, this step strips away the first part
		-- You're now left with only the reletive path
		local projectStart, projectEnd = string.find(path, "MeepMeep/")
		if (not projectStart) then
			projectStart, projectEnd = string.find(path, "HonkHonk/")
		end

		if (projectStart) then
			path = string.sub(path, projectEnd + 1)
		end
	end

	local isSucces = false

	if (type == "lua") then
		if (package.loaded[path]) then
			Log.warning("Reloaded lua file: " .. tostring(path))
			package.loaded[path] = nil
			require(path)

			class:__hotReloadClasses()

			isSucces = true
		else
			-- Log.warning("Package: ".. tostring(path) .. " was not loaded")
			isSucces = false
		end
	elseif (type == "glsl") then
		self:reloadShader(path, type)
	elseif (type == "obj") then
		self:reloadModel(path, type)
	elseif (type == "png" or type == "jpg" or type == "jpeg") then
		self:reloadTexture(path, type)
	else
		isSucces = false
	end

	self.broadcaster:broadcast(path, {path = path, type = type, reloaded = isSucces})

	return isSucces
end

function AssetManager:reloadShader(path, type)
	if (Engine.isShaderLoaded(path .. "." .. type)) then
		Log.warning("Reloaded shader: " .. tostring(path) .. ", extension: " .. tostring(type))
		Engine.reloadShader(path .. "." .. type)
	end
end

function AssetManager:reloadTexture(path, type)
	if (Engine.isTextureLoaded(path .. "." .. type)) then
		Log.warning("Reloaded texture: " .. tostring(path) .. ", extension: " .. tostring(type))
		Engine.reloadTexture(path .. "." .. type)
	end
end

function AssetManager:reloadModel(path, type)
	if (Engine.isModelLoaded(path .. "." .. type)) then
		Log.warning("Reloaded model: " .. tostring(path) .. ", extension: " .. tostring(type))
		-- Engine.reloadModel(path .. "." .. type)
		Log.error("Engine.reloadModel not implemented yet!")
	end
end
