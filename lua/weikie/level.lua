--require "lua/LuaXML/LuaXml"
--require "lua/LuaXML/test"
require "lua/weikie/floor"

Level = class(Level, function(self)
	Log.waka("level init")

	self.local_arr = {}
	self:init()
end)


-- local arr = {}
-- local arr2 = {}

function Level:init()
	local loopCount = 20
	local arr = self.local_arr

	for i=1, loopCount do
		arr[i] = {}
		for n=1, loopCount do
			arr[i][n] = 1
		end
	end

	self:_doFloor()
end

function Level:printTable()
	Log.waka(arr)
end

function Level:printTableValue(x, y)
	local innerArray = self.local_arr[x]
	local b = innerArray[y]
	Log.waka(type(b))
	Log.waka(b)
	--Log.waka(arr2[x])
end

function Level:setTile(x, y, value)
	self.local_arr[x][y].value = value
end

function Level:_doFloor()
	self.floor = Floor()
end
