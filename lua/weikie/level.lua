--require "lua/LuaXML/LuaXml"
--require "lua/LuaXML/test"
require "lua/weikie/floor"
require "lua/base/base"
require "lua/weikie/enum"

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
	self.player = nil

end)

function Level:loadLevelFromFile(fileName)
	--require
	local SLAXML = require "lua/SLAXML-master/slaxdom"
	--read the file
	local myxml = io.open(Engine.system.contentPath .. "/" .. fileName):read('*all')
	--do stuff to read xml
	local doc = SLAXML:dom(myxml)
	local floorIndex = 1
	local objectsIndex = 2


	for i=1, #doc.root.el do
		local tile = doc.root.el[i]
		local x = tile.attr["x"]
		--local y = tile.attr["y"]
		local y = tile.attr["z"]
		local value = tile.el[floorIndex].attr["value"]

		--Set floor texture
		if tonumber(value) > 0 then
			self:setFloorTile(tonumber(x), tonumber(y), tonumber(value))
		end

		local objects = tile.el[objectsIndex]
		if objects ~= nil then
			for n=1, #objects.el do
				local nodeName = objects.el[n].name
				local objVal = objects.el[n].attr["value"]

				if (nodeName == "character") then
					--create load character

				elseif (nodeName == "object") then
					--create and load object

				else
					Log.waka("Unknown node " .. nodeName .. " in Level:loadLevelFromFile, go fix.")
				end
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

function Level:setFloorTile(x, y, value)
	local tile = self.floorTiles[x + 1][y + 1] --I hate arrays starting from 1
	tile:setValue(value)
	--If error happens, out of bounds, Keep in mind arrays start from 1 in lua normally
end

function Level:_loadFloor()
	--self.floor = Floor()
end
