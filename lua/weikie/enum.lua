require "lua/weikie/struct"

Enum = class(Enum, function(self)
	self.FLOOR_TILES = {}
	self.ENVIRONMENT_OBJECTS = {}
	self.CHARACTERS = {}
	self.PROJECTILES = {}

	self.basePathFloorTiles		= "content/images/textures/tiles/"
	self.basePathObjectsModel 	= "content/models/"
	self.basePathObjectsTexture	= "content/images/textures/"
	self.basePathCharacters		= "content/images/characters/"
	self.basePathProjectiles	= "content/images/effects/"
	self.characterModel 		= "content/models/special/holder_character.obj"


	self._wallObjectBasePath = "content/models/tiles/"

	self._wallObjects = {}
	self._wallTextures = {}
	self._wallObjectArray = {}

	self._adjacencyToWall = {}

	self:importFloorTiles()
	self:importObjects()
	self:importCharacters()
	self:importProjectiles()
end)

function Enum:importProjectiles()
	self:addProjectile("attack_player.png")
	self:addProjectile("attack_monster_spider.png")

	--model
	Engine.importModel(self.characterModel)

	--Import floor textures
	for i = 1, table.getn(self.PROJECTILES) do
		Engine.importTexture(self.PROJECTILES[i], true)
	end
end

function Enum:importCharacters()
	self:addCharacter("player_forward.png")
	self:addCharacter("bomb.png")

	--model
	Engine.importModel(self.characterModel)

	--Import floor textures
	for i = 1, table.getn(self.CHARACTERS) do
		Engine.importTexture(self.CHARACTERS[i], true)
	end
end

function Enum:importObjects()
	Engine.importTexture("content/images/textures/tiles/rocky/rocky_wall.png", true)
	Engine.importTexture("content/images/textures/tiles/rocky/rocky_floor.png", true)

	self:_addWallObject("wall_01.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_02.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_03.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_04_fill.obj",			"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_05.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_06.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_07.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_08.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_09.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_10.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_11.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_12.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_13.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_14.obj",					"tiles/rocky/rocky_wall.png")
	self:_addWallObject("wall_15.obj",					"tiles/rocky/rocky_wall.png")

	self:_addWallObject("cave_floor.obj",					"tiles/rocky/rocky_wall.png")


	self:addObject("props/cave_rock_big_1.obj", "props/icy/fountain.png")
	self:addObject("props/cave_rock_big_2.obj", "props/icy/snowman.png")
	self:addObject("props/cave_rock_big_3.obj", "props/molten/molten_chair.png")

	--Import floor textures
	for i = 1, table.getn(self.ENVIRONMENT_OBJECTS) do
		Engine.importTexture(self.ENVIRONMENT_OBJECTS[i].texture)
		Engine.importModel(self.ENVIRONMENT_OBJECTS[i].model)
	end

	for path, _ in pairs(self._wallObjects) do
		Engine.importModel(path)
	end

	for path, _ in pairs(self._wallTextures) do
		Engine.importTexture(path)
	end

end


function Enum:_addWallObject(modelPath, texturePath)
	table.insert(self._wallObjectArray, self._wallObjectBasePath .. modelPath)

	self._wallObjects[self._wallObjectBasePath .. modelPath] = true
	self._wallTextures[texturePath] = true


end

function Enum:importFloorTiles()
	self:addFloorTile("empty.png")
	self:addFloorTile("icy/icy_floor1.png")
	self:addFloorTile("icy/icy_floor2.png")
	self:addFloorTile("icy/icy_floor3.png")

	--Import the model
	Engine.importModel("content/models/tiles/cave_floor.obj")

	--Import floor textures
	for i = 1, table.getn(self.FLOOR_TILES) do
		Engine.importTexture(self.FLOOR_TILES[i])
	end
end

function Enum:addProjectile(texturePath)
	table.insert(self.PROJECTILES, self.basePathProjectiles .. texturePath)
end

function Enum:addCharacter(texturePath)
	table.insert(self.CHARACTERS, self.basePathCharacters .. texturePath)
end

function Enum:addObject(modelPath, texturePath)
	local temp = ModelTexture()
	temp.model 		= self.basePathObjectsModel .. modelPath
	temp.texture 	= self.basePathObjectsTexture .. texturePath
	table.insert(self.ENVIRONMENT_OBJECTS, temp)
end


function Enum:addFloorTile(path)
	table.insert(self.FLOOR_TILES, self.basePathFloorTiles .. path)
end
