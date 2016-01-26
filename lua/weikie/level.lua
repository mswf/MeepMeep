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
	--cleanup from previous if andysgolf2
	if self.player ~= nil then
		self.player:destroy()
	end
	for i=1, table.getn(self.enemies) do
		self.enemies[i]:destroy()
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
	local tiles = self.floorTiles
	for x=1, self.width do
		tiles[x] = {}
		for y=1, self.height do
			tiles[x][y] = Floor()
			tiles[x][y].setPosition(tiles[x][y], x * TILE_WIDTH, 0, (y * TILE_LENGTH))
			tiles[x][y]:setPosition(1000,10000,10000)
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
		obj:_loadModel(ENUM.ENVIRONMENT_OBJECTS[value].model)
		obj:setMaterial(ENUM.ENVIRONMENT_OBJECTS[value].texture)
		--+1 because pivot point
		obj:setPosition(x, 0, y+1)
	end
end

local wallTypes = {
	outCorner_NW = {index = 1, rotation = 0},
	outCorner_SW = {index = 1, rotation = 3},
	outCorner_SE = {index = 1, rotation = 2},
	outCorner_NE = {index = 1, rotation = 1},

	inCorner_SE = {index = 2, rotation = 0},
	inCorner_NE = {index = 2, rotation = 3},
	inCorner_NW = {index = 2, rotation = 2},
	inCorner_SW = {index = 2, rotation = 1},

	single_W = {index = 3, rotation = 0},
	single_S = {index = 3, rotation = 3},
	single_E = {index = 3, rotation = 2},
	single_N = {index = 3, rotation = 1},

	filler = {index = 4, rotation = 0},

	outBend_NW = {index = 5, rotation = 0},
	outBend_SW = {index = 5, rotation = 3},
	outBend_SE = {index = 5, rotation = 2},
	outBend_NE = {index = 5, rotation = 1},

	half_T1_SE = {index = 6, rotation = 0},
	half_T1_NE = {index = 6, rotation = 3},
	half_T1_SW = {index = 6, rotation = 1},
	half_T1_NW = {index = 6, rotation = 2},

 	T_N= {index = 7, rotation = 0},
 	T_W= {index = 7, rotation = 3},
 	T_S= {index = 7, rotation = 2},
 	T_E= {index = 7, rotation = 1},

	half_T2_NE = {index = 8, rotation = 0},
	half_T2_NW = {index = 8, rotation = 3},
	half_T2_SW = {index = 8, rotation = 2},
	half_T2_SE = {index = 8, rotation = 1},

	doubleCorner_LR_A = {index = 9, rotation = 0},
	doubleCorner_LR_D = {index = 9, rotation = 1},

	tripleCorner_SE = {index = 10, rotation = 0},
	tripleCorner_NE = {index = 10, rotation = 3},
	tripleCorner_NW = {index = 10, rotation = 2},
	tripleCorner_SW = {index = 10, rotation = 1},

	cross = {index = 11, rotation = 0},

	island = {index = 15, rotation = 0},

	doubleSided_V = {index = 12, rotation = 0},
	doubleSided_H = {index = 12, rotation = 1},


	doubleCorner_N = {index = 13, rotation = 0},
	doubleCorner_W = {index = 13, rotation = 3},
	doubleCorner_S = {index = 13, rotation = 2},
	doubleCorner_E = {index = 13, rotation = 1},

	outset_S = {index = 14, rotation = 0},
	outset_E = {index = 14, rotation = 3},
	outset_N = {index = 14, rotation = 2},
	outset_W = {index = 14, rotation = 1},
}

local lookupTable = {}

lookupTable[28] = wallTypes.outCorner_NW
lookupTable[30] = wallTypes.outCorner_NW
lookupTable[60] = wallTypes.outCorner_NW
lookupTable[62] = wallTypes.outCorner_NW
lookupTable[156] = wallTypes.outCorner_NW
lookupTable[158] = wallTypes.outCorner_NW
lookupTable[188] = wallTypes.outCorner_NW
lookupTable[190] = wallTypes.outCorner_NW

lookupTable[7] = wallTypes.outCorner_SW
lookupTable[15] = wallTypes.outCorner_SW
lookupTable[39] = wallTypes.outCorner_SW
lookupTable[47] = wallTypes.outCorner_SW
lookupTable[135] = wallTypes.outCorner_SW
lookupTable[143] = wallTypes.outCorner_SW
lookupTable[167] = wallTypes.outCorner_SW
lookupTable[175] = wallTypes.outCorner_SW

lookupTable[193] = wallTypes.outCorner_SE
lookupTable[195] = wallTypes.outCorner_SE
lookupTable[201] = wallTypes.outCorner_SE
lookupTable[203] = wallTypes.outCorner_SE
lookupTable[225] = wallTypes.outCorner_SE
lookupTable[227] = wallTypes.outCorner_SE
lookupTable[233] = wallTypes.outCorner_SE
lookupTable[235] = wallTypes.outCorner_SE

lookupTable[112] = wallTypes.outCorner_NE
lookupTable[114] = wallTypes.outCorner_NE
lookupTable[120] = wallTypes.outCorner_NE
lookupTable[122] = wallTypes.outCorner_NE
lookupTable[240] = wallTypes.outCorner_NE
lookupTable[242] = wallTypes.outCorner_NE
lookupTable[248] = wallTypes.outCorner_NE
lookupTable[250] = wallTypes.outCorner_NE

lookupTable[247] = wallTypes.inCorner_SE
lookupTable[253] = wallTypes.inCorner_NE
lookupTable[127] = wallTypes.inCorner_NW
lookupTable[223] = wallTypes.inCorner_SW

lookupTable[31] = wallTypes.single_W
lookupTable[63] = wallTypes.single_W
lookupTable[159] = wallTypes.single_W
lookupTable[191] = wallTypes.single_W

lookupTable[199] = wallTypes.single_S
lookupTable[207] = wallTypes.single_S
lookupTable[231] = wallTypes.single_S
lookupTable[239] = wallTypes.single_S

lookupTable[241] = wallTypes.single_E
lookupTable[243] = wallTypes.single_E
lookupTable[249] = wallTypes.single_E
lookupTable[251] = wallTypes.single_E

lookupTable[124] = wallTypes.single_N
lookupTable[126] = wallTypes.single_N
lookupTable[252] = wallTypes.single_N
lookupTable[254] = wallTypes.single_N

lookupTable[255] = wallTypes.filler

lookupTable[20] = wallTypes.outBend_NW
lookupTable[22] = wallTypes.outBend_NW
lookupTable[52] = wallTypes.outBend_NW
lookupTable[54] = wallTypes.outBend_NW
lookupTable[148] = wallTypes.outBend_NW
lookupTable[150] = wallTypes.outBend_NW
lookupTable[180] = wallTypes.outBend_NW
lookupTable[182] = wallTypes.outBend_NW

lookupTable[5] = wallTypes.outBend_SW
lookupTable[13] = wallTypes.outBend_SW
lookupTable[37] = wallTypes.outBend_SW
lookupTable[45] = wallTypes.outBend_SW
lookupTable[133] = wallTypes.outBend_SW
lookupTable[141] = wallTypes.outBend_SW
lookupTable[165] = wallTypes.outBend_SW
lookupTable[173] = wallTypes.outBend_SW

lookupTable[65] = wallTypes.outBend_SE
lookupTable[67] = wallTypes.outBend_SE
lookupTable[73] = wallTypes.outBend_SE
lookupTable[75] = wallTypes.outBend_SE
lookupTable[97] = wallTypes.outBend_SE
lookupTable[99] = wallTypes.outBend_SE
lookupTable[105] = wallTypes.outBend_SE
lookupTable[107] = wallTypes.outBend_SE

lookupTable[80] = wallTypes.outBend_NE
lookupTable[82] = wallTypes.outBend_NE
lookupTable[88] = wallTypes.outBend_NE
lookupTable[90] = wallTypes.outBend_NE
lookupTable[208] = wallTypes.outBend_NE
lookupTable[210] = wallTypes.outBend_NE
lookupTable[216] = wallTypes.outBend_NE
lookupTable[218] = wallTypes.outBend_NE


lookupTable[116] = wallTypes.half_T1_SE
lookupTable[118] = wallTypes.half_T1_SE
lookupTable[244] = wallTypes.half_T1_SE
lookupTable[246] = wallTypes.half_T1_SE

lookupTable[29] = wallTypes.half_T1_NE
lookupTable[61] = wallTypes.half_T1_NE
lookupTable[157] = wallTypes.half_T1_NE
lookupTable[189] = wallTypes.half_T1_NE

lookupTable[209] = wallTypes.half_T1_SW
lookupTable[211] = wallTypes.half_T1_SW
lookupTable[217] = wallTypes.half_T1_SW
lookupTable[219] = wallTypes.half_T1_SW

lookupTable[71] = wallTypes.half_T1_NW
lookupTable[79] = wallTypes.half_T1_NW
lookupTable[103] = wallTypes.half_T1_NW
lookupTable[111] = wallTypes.half_T1_NW


lookupTable[84] = wallTypes.T_N
lookupTable[86] = wallTypes.T_N
lookupTable[212] = wallTypes.T_N
lookupTable[214] = wallTypes.T_N

lookupTable[21] = wallTypes.T_W
lookupTable[53] = wallTypes.T_W
lookupTable[149] = wallTypes.T_W
lookupTable[181] = wallTypes.T_W

lookupTable[69] = wallTypes.T_S
lookupTable[77] = wallTypes.T_S
lookupTable[101] = wallTypes.T_S
lookupTable[109] = wallTypes.T_S

lookupTable[81] = wallTypes.T_E
lookupTable[83] = wallTypes.T_E
lookupTable[89] = wallTypes.T_E
lookupTable[91] = wallTypes.T_E

lookupTable[197] = wallTypes.half_T2_NE
lookupTable[205] = wallTypes.half_T2_NE
lookupTable[229] = wallTypes.half_T2_NE
lookupTable[237] = wallTypes.half_T2_NE

lookupTable[113] = wallTypes.half_T2_NW
lookupTable[115] = wallTypes.half_T2_NW
lookupTable[121] = wallTypes.half_T2_NW
lookupTable[123] = wallTypes.half_T2_NW

lookupTable[92] = wallTypes.half_T2_SW
lookupTable[94] = wallTypes.half_T2_SW
lookupTable[220] = wallTypes.half_T2_SW
lookupTable[222] = wallTypes.half_T2_SW

lookupTable[23] = wallTypes.half_T2_SE
lookupTable[55] = wallTypes.half_T2_SE
lookupTable[151] = wallTypes.half_T2_SE
lookupTable[183] = wallTypes.half_T2_SE

lookupTable[221] = wallTypes.doubleCorner_LR_A
lookupTable[119] = wallTypes.doubleCorner_LR_D

lookupTable[93] = wallTypes.tripleCorner_SE
lookupTable[87] = wallTypes.tripleCorner_NE
lookupTable[213] = wallTypes.tripleCorner_NW
lookupTable[117] = wallTypes.tripleCorner_SW

lookupTable[117] = wallTypes.cross

lookupTable[117] = wallTypes.cross


lookupTable[155] = wallTypes.doubleSided_V
lookupTable[177] = wallTypes.doubleSided_V
lookupTable[179] = wallTypes.doubleSided_V
lookupTable[185] = wallTypes.doubleSided_V
lookupTable[187] = wallTypes.doubleSided_V

lookupTable[68] = wallTypes.doubleSided_H
lookupTable[70] = wallTypes.doubleSided_H
lookupTable[76] = wallTypes.doubleSided_H
lookupTable[78] = wallTypes.doubleSided_H
lookupTable[100] = wallTypes.doubleSided_H
lookupTable[102] = wallTypes.doubleSided_H
lookupTable[108] = wallTypes.doubleSided_H
lookupTable[110] = wallTypes.doubleSided_H
lookupTable[196] = wallTypes.doubleSided_H
lookupTable[198] = wallTypes.doubleSided_H
lookupTable[204] = wallTypes.doubleSided_H
lookupTable[206] = wallTypes.doubleSided_H
lookupTable[228] = wallTypes.doubleSided_H
lookupTable[230] = wallTypes.doubleSided_H
lookupTable[236] = wallTypes.doubleSided_H
lookupTable[238] = wallTypes.doubleSided_H

lookupTable[215] = wallTypes.doubleCorner_N
lookupTable[245] = wallTypes.doubleCorner_W
lookupTable[125] = wallTypes.doubleCorner_S
lookupTable[95] = wallTypes.doubleCorner_E

lookupTable[1] = wallTypes.outset_S
lookupTable[3] = wallTypes.outset_S
lookupTable[9] = wallTypes.outset_S
lookupTable[11] = wallTypes.outset_S
lookupTable[33] = wallTypes.outset_S
lookupTable[35] = wallTypes.outset_S
lookupTable[41] = wallTypes.outset_S
lookupTable[43] = wallTypes.outset_S
lookupTable[129] = wallTypes.outset_S
lookupTable[131] = wallTypes.outset_S
lookupTable[137] = wallTypes.outset_S
lookupTable[139] = wallTypes.outset_S
lookupTable[161] = wallTypes.outset_S
lookupTable[163] = wallTypes.outset_S
lookupTable[169] = wallTypes.outset_S
lookupTable[171] = wallTypes.outset_S

lookupTable[64] = wallTypes.outset_E
lookupTable[66] = wallTypes.outset_E
lookupTable[72] = wallTypes.outset_E
lookupTable[74] = wallTypes.outset_E
lookupTable[96] = wallTypes.outset_E
lookupTable[98] = wallTypes.outset_E
lookupTable[104] = wallTypes.outset_E
lookupTable[106] = wallTypes.outset_E
lookupTable[192] = wallTypes.outset_E
lookupTable[194] = wallTypes.outset_E
lookupTable[200] = wallTypes.outset_E
lookupTable[202] = wallTypes.outset_E
lookupTable[224] = wallTypes.outset_E
lookupTable[226] = wallTypes.outset_E
lookupTable[232] = wallTypes.outset_E
lookupTable[234] = wallTypes.outset_E

lookupTable[16] = wallTypes.outset_N
lookupTable[18] = wallTypes.outset_N
lookupTable[24] = wallTypes.outset_N
lookupTable[26] = wallTypes.outset_N
lookupTable[48] = wallTypes.outset_N
lookupTable[50] = wallTypes.outset_N
lookupTable[56] = wallTypes.outset_N
lookupTable[58] = wallTypes.outset_N
lookupTable[144] = wallTypes.outset_N
lookupTable[146] = wallTypes.outset_N
lookupTable[152] = wallTypes.outset_N
lookupTable[154] = wallTypes.outset_N
lookupTable[176] = wallTypes.outset_N
lookupTable[178] = wallTypes.outset_N
lookupTable[184] = wallTypes.outset_N
lookupTable[186] = wallTypes.outset_N

lookupTable[4] = wallTypes.outset_W
lookupTable[6] = wallTypes.outset_W
lookupTable[12] = wallTypes.outset_W
lookupTable[14] = wallTypes.outset_W
lookupTable[36] = wallTypes.outset_W
lookupTable[38] = wallTypes.outset_W
lookupTable[44] = wallTypes.outset_W
lookupTable[46] = wallTypes.outset_W
lookupTable[132] = wallTypes.outset_W
lookupTable[134] = wallTypes.outset_W
lookupTable[140] = wallTypes.outset_W
lookupTable[142] = wallTypes.outset_W
lookupTable[164] = wallTypes.outset_W
lookupTable[166] = wallTypes.outset_W
lookupTable[172] = wallTypes.outset_W
lookupTable[174] = wallTypes.outset_W


lookupTable[17] = wallTypes.doubleSided_V
lookupTable[19] = wallTypes.doubleSided_V
lookupTable[25] = wallTypes.doubleSided_V
lookupTable[27] = wallTypes.doubleSided_V
lookupTable[49] = wallTypes.doubleSided_V
lookupTable[51] = wallTypes.doubleSided_V
lookupTable[57] = wallTypes.doubleSided_V
lookupTable[59] = wallTypes.doubleSided_V
lookupTable[145] = wallTypes.doubleSided_V
lookupTable[147] = wallTypes.doubleSided_V
lookupTable[153] = wallTypes.doubleSided_V

lookupTable[0] = wallTypes.island
lookupTable[2] = wallTypes.island
lookupTable[8] = wallTypes.island
lookupTable[10] = wallTypes.island
lookupTable[32] = wallTypes.island
lookupTable[34] = wallTypes.island
lookupTable[40] = wallTypes.island
lookupTable[42] = wallTypes.island
lookupTable[128] = wallTypes.island
lookupTable[130] = wallTypes.island
lookupTable[136] = wallTypes.island
lookupTable[138] = wallTypes.island
lookupTable[160] = wallTypes.island
lookupTable[162] = wallTypes.island
lookupTable[168] = wallTypes.island
lookupTable[170] = wallTypes.island





local function getWallIndexAndRotationFromCode(wallCode)
	local index = 4
	local rotation = 0



end

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
				if (math.random() > 0.8) then
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
		local oldX = x
		x = y
		y = oldX

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
		local num = 1
		for i=1,8 do
			if (neighbours[i]) then
				codes[i] = math.pow(2, i-1)
			else
				codes[i] = 0
			end
		end

		return bit.bor(unpack(codes))
	end


	for x=1, maxX do
		for y=1, maxY do
			if(grid[x][y]) then
				local adjacencyCode = getAdjacencyCode(grid, y, x)

				if (lookupTable[adjacencyCode]) then

				else
					Log.steb("Could't find: " .. adjacencyCode)
				end

				local wallData = lookupTable[adjacencyCode] or {index = 4, rotation = 0}

				-- wallData.rotation = wallData.rotation + 2

				local obj = ObjectEntity()
				obj:_loadModel(ENUM._wallObjectArray[wallData.index])
				obj:setMaterial("content/images/textures/tiles/rocky/rocky_wall.png")
				--+1 because pivot point
				obj:setPosition(x, 0, y+1)

				obj:setYaw((wallData.rotation*-1)/4)

				-- if (rot == 0) then
				-- 	obj:setYaw(0)
				-- elseif (rot == 1) then
				-- 	obj:setYaw(0.75)
				-- else
				-- 	obj:destroy()
				-- end

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
