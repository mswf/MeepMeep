
require "lua/application/graph/graph"
require "lua/application/graph/cairopentagon"

CairoGraph = class(CairoGraph, Graph, function(self, rootX, rootY)
	self.size = 1

	self._width = 0
	self._height = 0

	self:_calculatePentagonOffset(0.5)
end)

function CairoGraph:setSize(newSize)
	self.size = newSize

	self:_calculatePentagonOffset(0.5)
end

function CairoGraph:_calculatePentagonOffset(e)
	if (e < 0.5) then
		self.offset = math.lerp(0, self.size*((math.sqrt(3)-1)*0.5), e*2)
	elseif (e > 0.5) then
		self.offset = math.lerp(self.size*((math.sqrt(3)-1)*0.5), self.size, (e-.5)*2)
	else
		self.offset = self.size*((math.sqrt(3)-1)*0.5)
	end
end

function CairoGraph:initializeToDimensions(width, height)
	local cairoConstructor = CairoPentagon

	local grid = {}

	self._grid = grid
	for x=1, width do
		grid[x] = {}
		for y=1, height do
			grid[x][y] = {}

			local z1 = cairoConstructor(self)
			z1:setPosition(x,y,1)
			grid[x][y][1] = z1
			local z2 = cairoConstructor(self)
			z2:setPosition(x,y,2)
			grid[x][y][2] = z2
		end
	end

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

function CairoGraph:getGridPositionFromNode(cairoPentagon)
	local gridX = self._grid

	local numGridX = #gridX


	for x=1, numGridX do
		local gridY = gridX[x]
		local numGridY = #gridY

		for y=1, numGridY do
			for z=1,2 do
				if (gridY[y][z].neighbours == cairoPentagon.neighbours) then
					return x, y, z
				end
			end
		end
	end
	Log.error("[CairoGraph] couldn't find node")
	return nil
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
