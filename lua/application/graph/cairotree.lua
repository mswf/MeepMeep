
require "lua/application/graph/tree"

-- GLOBALCOUNT = GLOBALCOUNT or 1
CairoTree = class(CairoTree, Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._width = 0
	self._height = 0

	self._currentHovered = nil

	self._currentPath = {}

	self._grid = {}

	-- local num = GLOBALCOUNT
	-- GlobalBroadcaster:register(self, "ON_MOUSE_PRESS", function(self, params) Log.steb(num) end)
	-- GLOBALCOUNT = GLOBALCOUNT + 1


end)

function CairoTree:initialzeToDimensions(width, height)
	local cairoConstructor = CairoPentagon

	self._grid = {}
	for x=1, width do
		self._grid[x] = {}
		for y=1, height do
			self._grid[x][y] = {}

			local node1 = cairoConstructor(GlobalTree)
			node1:setPosition(x,y,1)
			local node2 = cairoConstructor(GlobalTree)
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
				node1:addNeighbour(self:getNodeAt(x,y-1,2))
				-- right
				node1:addNeighbour(self:getNodeAt(x,y,2))
				-- bottom
				node1:addNeighbour(self:getNodeAt(x,y+1,1))
				-- left
				node1:addNeighbour(self:getNodeAt(x-1,y,2))
				node1:addNeighbour(self:getNodeAt(x-1,y,1))

				local node2 = grid[x][y][2]
				-- top
				node2:addNeighbour(self:getNodeAt(x,y-1,2))
				-- right
				node2:addNeighbour(self:getNodeAt(x+1,y,1))
				node2:addNeighbour(self:getNodeAt(x+1,y,2))
				-- bottom
				node2:addNeighbour(self:getNodeAt(x,y+1,1))
				-- left
				node2:addNeighbour(self:getNodeAt(x,y,1))
			else
				local node1 = grid[x][y][1]
				-- top
				node1:addNeighbour(self:getNodeAt(x,y-1,1))
				node1:addNeighbour(self:getNodeAt(x,y-1,2))
				-- right
				node1:addNeighbour(self:getNodeAt(x+1,y,1))
				-- bottom
				node1:addNeighbour(self:getNodeAt(x,y,2))
				-- left
				node1:addNeighbour(self:getNodeAt(x-1,y,2))

				local node2 = grid[x][y][2]
				-- top
				node2:addNeighbour(self:getNodeAt(x,y,1))
				-- right
				node2:addNeighbour(self:getNodeAt(x+1,y,1))
				-- bottom
				node2:addNeighbour(self:getNodeAt(x,y+1,1))
				node2:addNeighbour(self:getNodeAt(x,y+1,2))
				-- left
				node2:addNeighbour(self:getNodeAt(x-1,y,2))
			end
		end
	end



	self._width = width
	self._height = height
end

function CairoTree:registerInput()

	-- local nodes = self._nodes
	-- local value = (math.sin(love.timer.getTime())+1) /4
	-- for i=1, #nodes do
	-- 	nodes[i]:generateVertices(value)
	-- end

	--#TODO:0 refactor this input the moment this is moved to the engine side
	local mouseX, mouseY = love.mouse.getPosition()

	local worldX = (mouseX - CAMOFFSET.X) / CAMOFFSET.ZOOM
	local worldY = (mouseY - CAMOFFSET.Y) / CAMOFFSET.ZOOM

	local gridPosX = worldX/self.size*.5
	local gridPosY = worldY/self.size*.5

	local gridX = math.floor(gridPosX) +1
	local gridY = math.floor(gridPosY) +1

	if  (gridX < 1 or gridX > self._width
		or gridY < 1 or gridY > self._height) then

		self:setHovered(nil)
		if (INPUTS.mouse["l"]) then
			self:setSelected(nil)
		end
		return
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

	self:setHovered(self._grid[gridX][gridY][zOffset])

	if (INPUTS.mouse["l"]) then
		self:setSelected(self._grid[gridX][gridY][zOffset])
	end

	if (INPUTS.key["p"] or INPUTS.mouse["r"]) then
		if (self._currentSelected and self._currentHovered) then
			self._currentPath = self:findPath(self._currentSelected, self._currentHovered)
		else
			Log.steb("Can't draw a path, either there's no currentSelected or no currentHovered")
		end
	end

	-- if (self._currentHovered and self._currentSelected) then
	-- 	self._path = self:getPathFro
	-- end
end

function CairoTree:addToGrid(cairoPentagon,x,y,z)
	self._grid[x][y][z] = cairoPentagon
end

function CairoTree:getNodeAt(x,y,z)
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
