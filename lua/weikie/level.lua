require "lua/weikie/floor"
require "lua/base/base"
require "lua/weikie/enum"
require "lua/weikie/objectEntity"

TILE_WIDTH = 1
TILE_LENGTH = 1


Level = class(Level, function(self)
	Log.waka("level init")
	ENUM = Enum()

	self.floorTiles = {}
	self.width = 20
	self.height = 15
	self:initLevelObjects()
	self:_loadFloor()
	self.player = nil
	self.enemies = {}
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
		local value = tonumber(tile.el[floorIndex].attr["value"])

		--Set floor texture
		if value > 1 then
			self:setFloorTile(tonumber(x), tonumber(y), value)
		end

		local objects = tile.el[objectsIndex]
		if objects ~= nil then
			for n=1, #objects.el do
				local nodeName = objects.el[n].name
				local objVal = tonumber(objects.el[n].attr["value"])
				if objVal == 0 then
					Log.waka("Object value is 0, this is not allowed (1 is first index)")
				end
				if (nodeName == "character") then
					--create load character
					self:createCharacter(objVal, x, y)
				elseif (nodeName == "object") then
					--create and load object
					self:createObject(objVal, x, y)
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
		end
	end
end

function Level:setFloorTile(x, y, value)
	local tile = self.floorTiles[x + 1][y + 1] --I hate arrays starting from 1
	tile:setValue(value)
	--If error happens, out of bounds, Keep in mind arrays start from 1 in lua normally
end

function Level:createCharacter(value, x, y)
	local character = nil
	if value == 1 then
		if self.player ~= nil then
			--destroy entity
		end
		self.player = Player()
		character = self.player
	else--if value == 2 then
		--Should store somewhere honestly, so that it can be cleaned up later
		character = Enemy()
		table.insert(self.enemies, character)
	end
	character:setPosition(x, 0, y)
	character:setMaterial(ENUM.CHARACTERS[value])
end

--I dont know what this is supposed to do
function Level:_loadFloor()
	--self.floor = Floor()
end

function Level:createObject(value, x, y)
	local obj = ObjectEntity()
	obj:_loadModel(ENUM.ENVIRONMENT_OBJECTS[value].model)
	obj:setMaterial(ENUM.ENVIRONMENT_OBJECTS[value].texture)
	obj:setPosition(x, 0, y)
end
