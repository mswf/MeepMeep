
require "lua/application/graph/graph"
require "lua/application/graph/cairopentagon"

CairoGraph = class(CairoGraph, Graph, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._width = 0
	self._height = 0

	self._grid = {}
end)

function CairoGraph:initializeToDimensions(width, height)
	local cairoConstructor = CairoPentagon

	self._grid = {}
	for x=1, width do
		self._grid[x] = {}
		for y=1, height do
			-- Log.steb(y)
			self._grid[x][y] = {}

			local node1 = cairoConstructor(self)
			node1:setPosition(x,y,1)
			local node2 = cairoConstructor(self)
			node2:setPosition(x,y,2)
		end
	end

	local grid = self._grid

	for x=1, width do
		for y=1, height do
			local isVertical = ((x + y) % 2 == 0)

			if (isVertical) then
				local node1 = grid[x][y][1]
				-- top
				node1:addNeighbour(self:getNodeByGridPos(x,y-1,2))
				-- right
				node1:addNeighbour(self:getNodeByGridPos(x,y,2))
				-- bottom
				node1:addNeighbour(self:getNodeByGridPos(x,y+1,1))
				-- left
				node1:addNeighbour(self:getNodeByGridPos(x-1,y,2))
				node1:addNeighbour(self:getNodeByGridPos(x-1,y,1))

				local node2 = grid[x][y][2]
				-- top
				node2:addNeighbour(self:getNodeByGridPos(x,y-1,2))
				-- right
				node2:addNeighbour(self:getNodeByGridPos(x+1,y,1))
				node2:addNeighbour(self:getNodeByGridPos(x+1,y,2))
				-- bottom
				node2:addNeighbour(self:getNodeByGridPos(x,y+1,1))
				-- left
				node2:addNeighbour(self:getNodeByGridPos(x,y,1))
			else
				local node1 = grid[x][y][1]
				-- top
				node1:addNeighbour(self:getNodeByGridPos(x,y-1,1))
				node1:addNeighbour(self:getNodeByGridPos(x,y-1,2))
				-- right
				node1:addNeighbour(self:getNodeByGridPos(x+1,y,1))
				-- bottom
				node1:addNeighbour(self:getNodeByGridPos(x,y,2))
				-- left
				node1:addNeighbour(self:getNodeByGridPos(x-1,y,2))

				local node2 = grid[x][y][2]
				-- top
				node2:addNeighbour(self:getNodeByGridPos(x,y,1))
				-- right
				node2:addNeighbour(self:getNodeByGridPos(x+1,y,1))
				-- bottom
				node2:addNeighbour(self:getNodeByGridPos(x,y+1,1))
				node2:addNeighbour(self:getNodeByGridPos(x,y+1,2))
				-- left
				node2:addNeighbour(self:getNodeByGridPos(x-1,y,2))
			end
		end
	end



	self._width = width
	self._height = height
end

function CairoGraph:addToGrid(cairoPentagon,x,y,z)
	self._grid[x][y][z] = cairoPentagon
end

function CairoGraph:getNodeByWorldCoord(worldX, worldY)
	local gridPosX = worldX/ (self.size*2)
	local gridPosY = worldY/ (self.size*2)

	local gridX = math.floor(gridPosX) +1
	local gridY = math.floor(gridPosY) +1

	if  (gridX < 1 or gridX > self._width
		or gridY < 1 or gridY > self._height) then
		return nil
	end

	local isVertical = ((gridX + gridY) % 2 == 0)

	local zOffset = 1
	if (isVertical) then
		if (math.floor(gridPosX) < math.round(gridPosX)) then
			zOffset = 2
		end
	else
		if (math.floor(gridPosY) < math.round(gridPosY)) then
			zOffset = 2
		end
	end

	-- return self:getNodeByGridPos(gridX, gridY, zOffset)
	return self._grid[gridX][gridY][zOffset]
end

function CairoGraph:getNodeByGridPos(x,y,z)
	local grid = self._grid

	if (grid[x]) then
		if (grid[x][y]) then
			if (grid[x][y][z]) then
				return grid[x][y][z]
			end
		end
	end

	return nil
end
