--require "lua/LuaXML/LuaXml"
--require "lua/LuaXML/test"
require "lua/weikie/floor"
require "lua/base/base"
require "lua/weikie/tiles"

TILE_WIDTH = 1
TILE_LENGTH = 1
ENUM = Enum()

Level = class(Level, function(self)
	Log.waka("level init")

	self.floorTiles = {}
	self.width = 20
	self.height = 15
	self:initLevelObjects()
	self:_loadFloor()
end)

function Level.loadLevelFromFile(fileName)
	--local path = "lua/"
	Log.waka("Loading file: " .. Engine.system.contentPath .. "/" .. fileName)

	--require
	local SLAXML = require "lua/SLAXML-master/slaxdom"
	--read the file
	local myxml = io.open(Engine.system.contentPath .. "/" .. fileName):read('*all')
	--do stuff to read xml
	local doc = SLAXML:dom(myxml)
	local floorIndex = 1
	local objectsIndex = 2

	--Log.waka(doc)--[1].attr["src"])
	Log.waka(#doc.root.el .. " Tiles")
	for i=1, #doc.root.el do
		--doc.root.el = tile
		local tile = doc.root.el[i]
		local x = tile.attr["x"]
		local y = tile.attr["y"]
		local z = tile.attr["z"]
		local value = tile.el[floorIndex].attr["value"]
		Log.waka("tile: x:" .. x .. " y:" .. y .. " z:" .. z)
		Log.waka("floor value: " .. value)
		local objects = tile.el[objectsIndex]
		if objects ~= nil then
			Log.waka("notnil")
			for n=1, #objects.el do
				local objVal = objects.el[n].attr["value"]
				Log.waka("Object value: " .. objVal)
				Log.waka("ROCKY" .. ENUM.floorTiles.Rock)

			end
		end
	end
end

function Level:initLevelObjects()
	local loopCount = 20
	local tiles = self.floorTiles
	for i=1, self.width do
		tiles[i] = {}
		for n=1, self.height do
			tiles[i][n] = Floor()
			tiles[i][n].setPosition(tiles[i][n], i * TILE_WIDTH, 0, (n * TILE_LENGTH))
			--tiles[i][n].setPosition(tiles[i][n], 5, 0, 1)
			--self:setFloorTile(i, n, 0)
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
	local tile = self.floorTiles[x][y]
	tile.setValue(tile, value)
end

function Level:_loadFloor()
	--self.floor = Floor()
end
