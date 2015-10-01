MeshBuilder = class(MeshBuilder, function(self)
	self._vertices = {}
	self._faces = {}
end)


function MeshBuilder:addVertex(vec3)
	local newIndex = #self._vertices + 1
	self._vertices[newIndex] = vec3
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

	for i=1, #self._vertices do
		local v = self._vertices[i]
		obj = obj .. "\n v " .. tostring(v[1]) .. " " .. tostring(v[2]) .. " " .. tostring(v[3])
	end

	for i=1, #self._faces do
		local f = self._faces[i]
		obj = obj .. "\n f " .. tostring(f[1]) .. " " .. tostring(f[2]) .. " " .. tostring(f[3])
	end

	Log.steb(obj)

	return obj
end
