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
	self.objects = {}
end)

function Level:loadLevelFromFile(fileName)
	--cleanup from previous if andysgolf2
	if self.player ~= nil then
		self.player:destroy()
		self.player = nil
	end
	for i=1, table.getn(self.enemies) do
		self.enemies[i]:destroy()
		self.enemies = {}
	end

	for i=1, table.getn(self.objects) do
		self.objects[i]:destroy()
		self.objects = {}
	end


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

	self:generateGridWithWalls()
end

function Level:initLevelObjects()
	Log.warning("[Level] disabled initLevelObjects")
	if true then return end
	local tiles = self.floorTiles
	for x=1, self.width do
		tiles[x] = {}
		for y=1, self.height do
			tiles[x][y] = Floor()
			tiles[x][y].setPosition(tiles[x][y], x * TILE_WIDTH, 0, (y * TILE_LENGTH))
		end
	end
end

function Level:setFloorTile(x, y, value)
	Log.warning("[Level] disabled setFloorTile")
	if true then return end
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


		local camera_entity = Entity()
		local camera = Camera()
		camera_entity:addComponent(camera);
		camera_entity:setPosition(0,6.5,5.4)
		camera_entity:setPitch(.137)
		camera_entity:setYaw(0.5)

		camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
		camera:makeActive()
		-- camera:setAspectRatio(1.6)
		camera:setFOV(45)

		self.player:addChild(camera_entity)


		-- CAMERA_ENTITY:setPosition(9,7,1)
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
	-- It's a wall
	if (value == 1) then
		self._maxX = self._maxX or 0
		self._maxY = self._maxY or 0

		self._maxX = math.max(self._maxX, x)
		self._maxY = math.max(self._maxY, y)

		self._wallObjects = self._wallObjects or {}

		table.insert(self._wallObjects, {x, y})
	else
		local obj = ObjectEntity()
		table.insert(self.objects, obj)
		obj:_loadModel(ENUM.ENVIRONMENT_OBJECTS[value].model)
		obj:setMaterial(ENUM.ENVIRONMENT_OBJECTS[value].texture)
		--+1 because pivot point
		obj:setPosition(x, 0, y+1)
	end
end

local wallLookupTable = require("lua/weikie/wall_lookup_table")
local math_pow = math.pow
local bit_bor = bit.bor

function Level:generateGridWithWalls()
	local maxX, maxY = self._maxX + 2, self._maxY + 2

	local grid = {}

	for x=1, maxX do
		grid[x] = {}
	end

	do -- parse the walls we cached earlier
		local walls = self._wallObjects

		for i=1, #walls do
			grid[walls[i][1]+1][walls[i][2]+1] = {}
		end
	end

	do -- hardcoded block
		for x=1, maxX do
			for y=1,maxY do
				if (math.random() > 0.6) then
					grid[x][y] = {}
				end
			end
		end
	end

	local getTileAt = function(grid, x, y)
		if (grid[x]) then
			if (grid[x][y]) then
				return grid[x][y]
			end
		end
		return nil
	end

	local getAdjacencyCode = function(grid, x, y)
		local neighbours = {
			getTileAt(grid,		x, 		y-1),
			getTileAt(grid,		x+1, 		y-1),
			getTileAt(grid,		x+1, 		y),

			getTileAt(grid,		x+1, 		y+1),

			getTileAt(grid,		x, 		y+1),
			getTileAt(grid,		x-1, 		y+1),
			getTileAt(grid,		x-1, 		y),

			getTileAt(grid,		x-1, 		y-1),
		}
		local codes = {}
		for i=1,8 do
			if (neighbours[i]) then
				codes[i] = math_pow(2, i-1)
			else
				codes[i] = 0
			end
		end

		return bit_bor(unpack(codes)) + 1
	end


	for x=1, maxX do
		for y=1, maxY do
			if(grid[x][y]) then
				local wallData = wallLookupTable[getAdjacencyCode(grid, x, y)]

				if (wallData == nil) then
					Log.warning("[Level] Could't find: a valid walltype")
					wallData = {index = 4, rotation = 0}
				end

				local obj = ObjectEntity()
				obj:_loadModel(ENUM._wallObjectArray[wallData.index])
				obj:setMaterial("content/images/textures/tiles/rocky/rocky_wall.png")
				--+1 because pivot point
				obj:setPosition(x, 0, y+1)

				obj:setYaw(wallData.rotation)
			else
				local obj = ObjectEntity()
				obj:_loadModel(ENUM._wallObjectArray[16])
				obj:setMaterial("content/images/textures/tiles/rocky/rocky_floor.png")
				--+1 because pivot point
				obj:setPosition(x, 0, y+1)
			end
		end
	end

end
