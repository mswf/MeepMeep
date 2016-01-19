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

function Level.loadLevelFromFile(fileName)
	Log.waka(fileName)
	Log.waka("Loading file: " .. fileName)

	--require
	local SLAXML = require "lua/SLAXML-master/slaxdom"
	--read the file
	local path = "lua/"
	local myxml = io.open(Engine.system.contentPath .. "/" .. path .. fileName):read('*all')
	--do stuff to read xml
	local doc = SLAXML:dom(myxml)


	Log.waka(doc)--[1].attr["src"])
	for i=1, #doc.root.el do
		--doc.root.el = tile
		Log.waka(#doc .. " Tiles")
		local x = doc.root.el[i].attr["x"]
		local y = doc.root.el[i].attr["y"]
		local z = doc.root.el[i].attr["z"]
		local value = doc.root.el["floor"].attr["value"]
		if doc.root.el["objects"] ~= nil then
			for n=1, #doc.root.el["objects"].el do

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
