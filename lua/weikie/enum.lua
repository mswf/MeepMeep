Enum = class(Enum, function(self)
	self.FLOOR_TILES = {}
	self.OBJECTS = {}
	self.numTiles = 0

	self.basePathFloorTiles = "content/images/textures/tiles/"

	self:addFloorTile("empty.png")
	self:addFloorTile("icy/icy_floor1.png")
	self:addFloorTile("icy/icy_floor2.png")
	self:addFloorTile("icy/icy_floor3.png")


	Engine.importModel("content/models/tiles/cave_floor.obj")

	--Import floor textures
	for i = 0, self.numTiles do
		Engine.importTexture(self.FLOOR_TILES[i])
	end

end)

function Enum:addFloorTile(tilePath)
	self.FLOOR_TILES[self.numTiles] = self.basePathFloorTiles .. tilePath
	self.numTiles = self.numTiles + 1
end
