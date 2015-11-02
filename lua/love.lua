

local generateTiles = function()
	LoveGame.nodes = {}

	GlobalTree = CairoTree(0,0)
	GlobalTree:setSize(40)
	GlobalTree:initialzeToDimensions(30, 30)
end

LoveGame = LoveGame or {}
function love.load()
	generateTiles()
end

function love.update(dt)
	local keyMagnitude = 10 / math.sqrt(CAMOFFSET.ZOOM)

	if (INPUTS.key["w"]) then
		CAMOFFSET.Y =  CAMOFFSET.Y + keyMagnitude
	end

	if (INPUTS.key["s"]) then
		CAMOFFSET.Y =  CAMOFFSET.Y - keyMagnitude
	end

	if (INPUTS.key["a"]) then
		CAMOFFSET.X =  CAMOFFSET.X + keyMagnitude
	end

	if (INPUTS.key["d"]) then
		CAMOFFSET.X =  CAMOFFSET.X - keyMagnitude
	end

	local changeZoom = function(amount)
		if (amount < 0 or CAMOFFSET.ZOOM > 0.01)
			and (amount > 0 or CAMOFFSET.ZOOM < 2) then

			CAMOFFSET.ZOOM = CAMOFFSET.ZOOM - amount

			-- CAMOFFSET.X = CAMOFFSET.X - amount*CAMOFFSET.X
			-- CAMOFFSET.Y = CAMOFFSET.Y - amount*CAMOFFSET.Y
		end
	end

	if (INPUTS.key["q"]) then
			changeZoom(- 0.05* math.sqrt(CAMOFFSET.ZOOM))
	end

	if (INPUTS.key["e"]) then
			changeZoom(0.05 * math.sqrt(CAMOFFSET.ZOOM))
	end

	if (INPUTS.mouse["wu"]) then
		changeZoom(- 0.05* math.sqrt(CAMOFFSET.ZOOM))

	end

	if (INPUTS.mouse["wd"]) then
		changeZoom(0.05 * math.sqrt(CAMOFFSET.ZOOM))
	end


	if (GlobalTree) then
		GlobalTree:registerInput()
	end


	INPUTS.mouse["wd"] = nil
	INPUTS.mouse["wu"] = nil


end

CAMOFFSET = {}
CAMOFFSET.X = 0
CAMOFFSET.Y = 0

CAMOFFSET.ZOOM = 1

function love.draw()

	love.graphics.translate(CAMOFFSET.X, CAMOFFSET.Y)
	love.graphics.scale(CAMOFFSET.ZOOM, CAMOFFSET.ZOOM)

	love.graphics.setColor(255,255,255)
  love.graphics.print("GwebSwag", 400, 300)

	if (GlobalTree) then
		GlobalTree:draw()
	end

end

INPUTS = {}
INPUTS.key = {}
INPUTS.mouse = {}

function love.keypressed(k)
	INPUTS.key[k] = true

	if (k == "r") then
		generateTiles()

	end
end

function love.keyreleased(key)
	INPUTS.key[key] = nil
end

function love.mousepressed(x, y, button)
	INPUTS.mouse[button] = {x, y}
end

function love.mousereleased(x, y, button)
	INPUTS.mouse[button] = nil
end



function love.focus(getFocus)
	if (not getFocus) then
		love.event.quit( )
	end
end



------------------------------------------------------------------------------------------------------
Tree = class(function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._currentHovered = nil
	self._currentSelected = nil

	self._currentPath = {}

	self._grid = {}

end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:draw()


	if (self._currentSelected) then
		self._currentSelected:drawSelected()
	end

	if (self._currentHovered) then
		self._currentHovered:drawHovered()
	end

	for k,v in pairs(self._nodes) do
		v:draw()
	end

	local curPath = self._currentPath
	for i=1, #curPath do


		local x, y = curPath[i]:getWorldCenter()
		love.graphics.setColor(255,100,100,255)

		love.graphics.circle("fill",x,y , self.size/5, 6)

		if (curPath[i+1]) then
			local x1, y1 = curPath[i]:getWorldCenter()
			local x2, y2 = curPath[i+1]:getWorldCenter()
			love.graphics.setColor(255,100,100,100)

			love.graphics.line(x1, y1, x2, y2)
		end


	end
end

function Tree:registerInput()

end

function Tree:addNode(node)
	table.insert(self._nodes, node)
end

function Tree:setHovered(newHovered)
	if (self._currentHovered == newHovered) then
		return
	end

	if (self._currentHovered) then

	end

	if (newHovered) then
		self._currentHovered = newHovered
	else
		self._currentHovered = nil
	end
end

function Tree:setSelected(newSelected)
	if (self._currentSelected == newSelected) then
		return
	end

	if (self._currentSelected) then

	end

	if (newSelected) then
		self._currentSelected = newSelected
	else
		self._currentSelected = nil
	end
end

function Tree:findPath(fromNode, toNode)
	local frontier = Queue()
	frontier:push(fromNode)
	local came_from = {}
	came_from[fromNode] = fromNode

	while (not frontier:isEmpty()) do
		local current = frontier:pop()

		if (current == toNode) then
			break
		end

		for _, neighbour in pairs(current.neighbours) do
			if (not came_from[neighbour]) then
				frontier:push(neighbour)
				came_from[neighbour] = current

			end
		end
	end

	local path = {}
	local current = toNode
	table.insert(path, current)

	while (current ~= fromNode) do
		current = came_from[current]
		table.insert(path, current)
	end

	return path
end

------------------------------------------------------------------------------------------------------
CairoTree = class(Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._width = 0
	self._height = 0

	self._currentHovered = nil

	self._currentPath = {}

	self._grid = {}
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

	local nodes = self._nodes
	local value = (math.sin(love.timer.getTime())+1) /4
	for i=1, #nodes do
		nodes[i]:generateVertices(value)
	end

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


------------------------------------------------------------------------------------------------------
Node = class(function(self, tree)
	self._vertices = nil
	self._edges = nil

	self._tree = tree
	self.neighbours = {}
	self.hasNeighbour = {}


	tree:addNode(self)

	self._RANDCOLOR = {}
	self._RANDCOLOR[1] = math.random()*205 +50
	self._RANDCOLOR[2] = math.random()*205 +50
	self._RANDCOLOR[3] = math.random()*205 +50
	self._RANDCOLOR[4] = 128

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*205 +50
	self._RANDCOLORLINE[2] = math.random()*205 +50
	self._RANDCOLORLINE[3] = math.random()*205 +50
	self._RANDCOLORLINE[4] = 50

end)

function Node:addNeighbour(neighbour)
	if (not neighbour) then
		return
	end

	if (not self.hasNeighbour[neighbour]) then
		table.insert(self.neighbours, neighbour)
		self.hasNeighbour[neighbour] = true
		neighbour:addNeighbour(self)
	end
end

function Node:setVertices(vertices)
	local newVertices = {}
	local newEdges = {}

	local cornerCount = #vertices
	for i=1, cornerCount do
		table.insert(newVertices, vertices[i][1])
		table.insert(newVertices, vertices[i][2])

		if (i < cornerCount) then
			table.insert(newEdges, {	vertices[i]	[1], 	vertices[i]		[2],
																vertices[i+1][1], vertices[i+1]	[2]})
		else
			table.insert(newEdges, { vertices[i]	[1], 	vertices[i]		[2],
																vertices[1]	[1], 	vertices[1]		[2]})
		end
	end

	self._edges = newEdges
	self._vertices = newVertices
end

function Node:draw()
	if (self._vertices) then

		local edges = self._edges
		for i=1, #edges do
			love.graphics.setColor(unpack(self._RANDCOLORLINE))


			love.graphics.line(unpack(edges[i]))

			-- love.graphics.setColor(unpack(self._RANDCOLOR))
			-- love.graphics.circle("fill", edges[i][1], edges[i][2], self._tree.size/5, 6)
		end

		-- love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawHovered()
	if (self._vertices) then
		love.graphics.setColor(unpack(self._RANDCOLORLINE))

		love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawSelected()
	local neighbours = self.neighbours

	for i=1, #neighbours do
		neighbours[i]:drawNeighbour()
	end

	if (self._vertices) then
		love.graphics.setColor(255,255,255,128)

		love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawNeighbour()
	if (self._vertices) then
		love.graphics.setColor(100,100,100,128)

		love.graphics.polygon('fill', self._vertices)
	end
end

------------------------------------------------------------------------------------------------------
CairoPentagon = class(Node, function(self, tree)

	self._vertices = nil
	self._edges = nil

	self._tree = tree
	self.neighbours = {}
	self.hasNeighbour = {}

	tree:addNode(self)

	self._RANDCOLOR = {}
	self._RANDCOLOR[1] = math.random()*205 +50
	self._RANDCOLOR[2] = math.random()*205 +50
	self._RANDCOLOR[3] = math.random()*205 +50

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*205 +50
	self._RANDCOLORLINE[2] = math.random()*205 +50
	self._RANDCOLORLINE[3] = math.random()*205 +50
end)

function CairoPentagon:setWorldCenter()
	local scale = self._tree.size
	local isVertical = ((self.gridX + self.gridY) % 2 == 0)

	local x, y = 0,0

	x = (self.gridX-1) * scale * 2
	y = (self.gridY-1) * scale * 2

	if (isVertical) then
		y = y + scale
		if (self.gridZ == 1) then
			x = x + scale*.5 - self.offset/2
		else
			x = x + scale* 1.5 + self.offset/2
		end
	else
		x = x + scale
		if (self.gridZ == 1) then
			y = y + scale *.5 - self.offset/2
		else
			y = y + scale * 1.5 + self.offset/2
		end
	end

	self.worldX = x
	self.worldY = y
end

function CairoPentagon:getWorldCenter()
	return self.worldX, self.worldY
end

--|----|----|---------|
--|    |    |    C    |
--| A  | B  |---------|
--|    |    |    D    |
--|----|----|---------|
--|    A    |    /    |
--|---------| C  / D  |
--|    B    |    /    |
--|---------|----/----|

-- DEBUGSKIPDRAW = true

function CairoPentagon:setPosition(gridX,gridY, gridZ)
	self.gridX = gridX
	self.gridY = gridY
	self.gridZ = gridZ

	-- self:setWorldCenter()

	self._tree:addToGrid(self, gridX, gridY, gridZ)

	self:generateVertices(0.5)
end

function CairoPentagon:generateVertices(e)
	local scale = self._tree.size

	local isVertical = ((self.gridX + self.gridY) % 2 == 0)

	local startX = (self.gridX-1) *2 *scale
	local startY = (self.gridY-1) *2 *scale


	local offset = 0
	if (e < 0.5) then
		offset = math.lerp(0, scale*((math.sqrt(3)-1)*0.5), e*2)
	elseif (e > 0.5) then
		offset = math.lerp(scale*((math.sqrt(3)-1)*0.5), scale, (e-.5)*2)
	else
		offset = scale*((math.sqrt(3)-1)*0.5)
	end
	self.offset = offset

	self:setWorldCenter()

	-- local offset = 0
	-- local offset = scale*((math.sqrt(3)-1)*0.5)
	-- local offset = scale

	if (isVertical) then
		if (self.gridZ == 1) then
			-- A
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX +scale,					startY +scale*2		- offset},
				{startX,								startY +scale*2},
				{startX - offset,				startY +scale},
				{startX,								startY },
				{startX +scale,					startY 						+ offset},
			})
		else
			-- B
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX+scale,					startY 						+ offset},
				{startX+scale*2,				startY },
				{startX+scale*2+offset,	startY + scale },
				{startX+scale*2,				startY +scale*2},
				{startX+scale,					startY +scale*2		- offset},
			})
		end
	else
		if (self.gridZ == 1) then
			-- C
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX+ offset,				startY+scale},
				{startX,								startY},
				{startX+scale,					startY- offset},
				{startX+scale*2,				startY},
				{startX+scale*2-offset,	startY+scale},
			})
		else
			-- D
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX+scale*2-offset,	startY+scale},
				{startX+scale*2,				startY+scale+scale},
				{startX+scale,					startY+scale+scale +offset},
				{startX,								startY+scale+scale},
				{startX + offset,				startY+scale},
			})
		end
	end
end
