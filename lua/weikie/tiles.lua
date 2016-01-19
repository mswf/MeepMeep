Enum = class(Enum, function(self)
	self.floorTiles = {}
	self.objects = {}

	self.floorTiles.Rock 	= 1
	self.floorTiles.Grass 	= 2

	self.objects.Wall_Rock 	= 1
	self.objects.Wall_Snow 	= 2
end)
