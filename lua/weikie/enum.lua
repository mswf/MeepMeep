require "lua/weikie/struct"

Enum = class(Enum, function(self)
	self.FLOOR_TILES = {}
	self.ENVIRONMENT_OBJECTS = {}
	self.CHARACTERS = {}

	self.basePathFloorTiles		= "content/images/textures/tiles/"
	self.basePathObjectsModel 	= "content/models/"
	self.basePathObjectsTexture	= "content/images/textures/props/"
	self.basePathCharacters		= "content/images/characters/"
	self.characterModel 		= "content/models/special/holder_character.obj"

	self:importFloorTiles()
	self:importObjects()
	self:importCharacters()
end)

function Enum:importCharacters()
	self:addCharacter("player.png")
	self:addCharacter("bomb.png")


	--model
	Engine.importModel(self.characterModel)

	--Import floor textures
	for i = 1, table.getn(self.CHARACTERS) do
		Engine.importTexture(self.CHARACTERS[i], true)
	end
end

function Enum:importObjects()
	self:addObject("props/cave_rock_big_1.obj", "icy/fountain.png")
	self:addObject("props/cave_rock_big_2.obj", "icy/snowman.png")
	self:addObject("props/cave_rock_big_3.obj", "molten/molten_chair.png")

	--Import floor textures
	for i = 1, table.getn(self.ENVIRONMENT_OBJECTS) do
		Engine.importTexture(self.ENVIRONMENT_OBJECTS[i].texture)
		Engine.importModel(self.ENVIRONMENT_OBJECTS[i].model)
	end
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
