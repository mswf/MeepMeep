--require "lua/LuaXML/LuaXml"
--require "lua/LuaXML/test"
require "lua/weikie/floor"

Level = class(Level, function(self)
	Log.waka("level init")

	self.levelObjects = {}
	self.width = 20
	self.height = 15
	self:initLevelObjects()
	self:_loadFloor()
end)


-- local arr = {}
-- local arr2 = {}

function Level:initLevelObjects()
	local loopCount = 20
	local arr = self.levelObjects

	--global i/n?
	for i=1, self.width do
		arr[i] = {}
		for n=1, self.height do
			arr[i][n] = 1
		end
	end
end

function Level:printTable()
	Log.waka(self.levelObjects[1])
end

function Level:printTableValue(x, y)
	local innerArray = self.levelObjects[x]
	local b = innerArray[y]
	Log.waka(type(b))
	Log.waka(b)
	--Log.waka(arr2[x])
end

function Level:setTile(x, y, value)
	self.levelObjects[x][y].value = value
end

function Level:_loadFloor()
	self.floor = Floor()
end
