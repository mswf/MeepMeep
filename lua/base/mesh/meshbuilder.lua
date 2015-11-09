--local IO = require("lua/Carbon/init").IO


-- function script_path()
--     return debug.getinfo(2, "S").source:sub(2):sub(0,-10):gsub("\\", "/")
-- end
-- ABS_PATH = script_path()

-- function Game.testMesh()
-- 	local Vector3 = Carbon.Math.Vector3
-- 	local mesh = MeshBuilder()
--
-- 	mesh:addVertex(Vector3(-1, 0,-1))
-- 	mesh:addVertex(Vector3(-1, 0, 1))
-- 	mesh:addVertex(Vector3( 1, 0,-1))
-- 	mesh:addVertex(Vector3( 1, 0, 1))
--
-- 	for i=1, 4 do
-- 		mesh:addNormal(Vector3( 0, 1, 0))
-- 	end
--
-- 	mesh:addTriangle(1,2,3)
-- 	mesh:addTriangle(2,4,3)
--
-- 	mesh:saveToFile("plane")
-- end


MeshBuilder = class(MeshBuilder, function(self)
	self._vertices = {}
	self._normals = {}
	self._faces = {}
end)


function MeshBuilder:addVertex(vec3)
	local newIndex = #self._vertices + 1
	self._vertices[newIndex] = vec3
	return newIndex
end

function MeshBuilder:addNormal(vec3)
	local newIndex = #self._normals + 1
	self._normals[newIndex] = vec3
	return newIndex
end

function MeshBuilder:addTriangle(i1, i2, i3)
	local face = {i1, i2, i3}
	local newIndex = #self._faces + 1
	self._faces[newIndex] = face
	return newIndex
end


function MeshBuilder:build()
	local obj = ""

	obj = obj .. "\n#Geometric Vertices"
	for i=1, #self._vertices do
		local v = self._vertices[i]
		obj = obj .. "\n v " .. tostring(v[1]) .. " " .. tostring(v[2]) .. " " .. tostring(v[3])
	end

	local useNormals = false

	if (#self._vertices == #self._normals) then
		useNormals = true

		obj = obj .. "\n#Vertex Normals"
		for i=1, #self._normals do
			local vn = self._normals[i]
			obj = obj .. "\n vn " .. tostring(vn[1]) .. " " .. tostring(vn[2]) .. " " .. tostring(vn[3])
		end
	elseif (not #self._normals == 0) then
		Log.steb("#" .. tostring(#self._normals) .. " of normals defined didn't correspond to the #" .. tostring(#self._vertices) .. " of vertices")
	end

	obj = obj .. "\n#Face Elements"
	if (not useNormals) then
		for i=1, #self._faces do
			local f = self._faces[i]
			obj = obj .. "\n f " .. tostring(f[1]) .. " " .. tostring(f[2]) .. " " .. tostring(f[3])
		end
	else
		for i=1, #self._faces do
			local f = self._faces[i]
			obj = obj .. "\n f " .. tostring(f[1]) .. "//1 " .. tostring(f[2]) .. "//1 " .. tostring(f[3]) .. "//1"
		end
	end

	-- Log.steb(obj)

	return obj
end

function MeshBuilder:saveToFile(fileName)
	local path

	if (ABS_PATH:len() > 5) then
		path = ABS_PATH .. "/objects/generated/"
	else
		Log.steb("Invalid path")
		return
	end

	local file, error = IO.Open(path .. fileName .. ".obj", "wb")
	if (not error) then
		local writeResult, writeError = file:Write(self:build())
		if (not writeError) then
			local closeResult = file:Close()
			if (not closeResult) then
				Log.steb("error while closing file")
			end
		else
			Log.steb(writeError)
		end
	else
		Log.steb(error)
	end


	-- local content = file:Read()
	-- Log.steb(content)





end
