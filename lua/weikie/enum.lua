require "lua/weikie/struct"

Enum = class(Enum, function(self)
	self.FLOOR_TILES = {}
	self.ENVIRONMENT_OBJECTS = {}
	self.CHARACTERS = {}

	self.numTiles = 0
	self.numObjects = 0
	self.numCharacters = 0

	self.basePathFloorTiles		= "content/images/textures/tiles/"
	self.basePathObjectsModel 	= "content/models/"
	self.basePathObjectsTexture	= "content/images/textures/props/"
	self.basePathCharacters		= "content/images/characters/"

	self:importFloorTiles()
	self:importObjects()
	self:importCharacters()
end)

function Enum:importCharacters()
	self:addCharacter("player.png")
	self:addCharacter("bomb.png")

	--Import floor textures
	for i = 0, self.numCharacters - 1 do
		Engine.importTexture(self.CHARACTERS[i])
	end
end

function Enum:importObjects()
	self:addObject("props/cave_rock_big_1.obj", "icy/fountain.png")
	self:addObject("props/cave_rock_big_2.obj", "icy/snowman.png")

	--Import floor textures
	for i = 0, self.numObjects - 1 do
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
	for i = 0, self.numTiles - 1 do
		Engine.importTexture(self.FLOOR_TILES[i])
	end
end

function Enum:addCharacter(texturePath)
	self.CHARACTERS[self.numCharacters] = self.basePathCharacters .. texturePath
	self.numCharacters = self.numCharacters + 1
end

function Enum:addObject(modelPath, texturePath)
	self.ENVIRONMENT_OBJECTS[self.numObjects] = ModelTexture()
	self.ENVIRONMENT_OBJECTS[self.numObjects].model 	= self.basePathObjectsModel .. modelPath
	self.ENVIRONMENT_OBJECTS[self.numObjects].texture 	= self.basePathObjectsTexture .. texturePath
	self.numObjects = self.numObjects + 1
end

function Enum:addFloorTile(path)
	self.FLOOR_TILES[self.numTiles] = self.basePathFloorTiles .. path
	self.numTiles = self.numTiles + 1
end
