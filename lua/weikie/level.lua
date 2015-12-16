--require "lua/LuaXML/LuaXml"
--require "lua/LuaXML/test"
require "lua/weikie/floor"

TILE_WIDTH = 1
TILE_LENGTH = 1

Level = class(Level, function(self)
	Log.waka("level init")

	self.floorTiles = {}
	self.width = 20
	self.height = 15
	self:initLevelObjects()
	self:_loadFloor()
end)

function Level:initLevelObjects()
	local loopCount = 20
	local tiles = self.floorTiles
	for i=1, self.width do
		tiles[i] = {}
		for n=1, self.height do
			tiles[i][n] = Floor()
			self:setFloorTile(i, n, 0)
		end
	end
end

function Level:printTable()
	Log.waka(self.floorTiles[1])
end

function Level:printTableValue(x, y)
	local innerArray = self.floorTiles[x]
	local b = innerArray[y]
	Log.waka(type(b))
	Log.waka(b)
	--Log.waka(arr2[x])
end

function Level:setFloorTile(x, y, value)
	--should be texture
	local tile = self.floorTiles[x][y]
	--tile:setPosition ?
	tile.setPosition(tile, x * TILE_WIDTH, 0, -(y * TILE_LENGTH))
	--tile.value = value

end

function Level:_loadFloor()
	self.floor = Floor()
end
