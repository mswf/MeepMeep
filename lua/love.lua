

LoveGame = LoveGame or {}
function love.load()
	LoveGame.nodes = {}

	GlobalTree = CairoTree(0,0)
	GlobalTree:setSize(40)
	GlobalTree:initialzeToDimensions(10,10)
end

function love.update(dt)
	GlobalTree:registerInput()

	local keyMagnitude = 10

	if (INPUTS["w"]) then
		CAMOFFSET.Y =  CAMOFFSET.Y + keyMagnitude
	end

	if (INPUTS["s"]) then
		CAMOFFSET.Y =  CAMOFFSET.Y - keyMagnitude
	end

	if (INPUTS["a"]) then
		CAMOFFSET.X =  CAMOFFSET.X + keyMagnitude
	end

	if (INPUTS["d"]) then
		CAMOFFSET.X =  CAMOFFSET.X - keyMagnitude
	end

	if (INPUTS["q"]) then
		if (CAMOFFSET.ZOOM > 0.1) then
			CAMOFFSET.ZOOM = CAMOFFSET.ZOOM - 0.05
		end
	end

	if (INPUTS["e"]) then
		if (CAMOFFSET.ZOOM < 2) then
			CAMOFFSET.ZOOM = CAMOFFSET.ZOOM + 0.05
		end
	end
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

	GlobalTree:draw()

end

INPUTS = {}

function love.keypressed(k)
	INPUTS[k] = true

	-- local keyMagnitude = 10
	-- if (k == "w") then
	-- 	CAMOFFSET.Y =  CAMOFFSET.Y + keyMagnitude
	-- end
	--
	-- if (k == "s") then
	-- 	CAMOFFSET.Y =  CAMOFFSET.Y - keyMagnitude
	-- end
	--
	-- if (k == "a") then
	-- 	CAMOFFSET.X =  CAMOFFSET.X + keyMagnitude
	-- end
	--
	-- if (k == "d") then
	-- 	CAMOFFSET.X =  CAMOFFSET.X - keyMagnitude
	-- end
end

function love.keyreleased(key)
	INPUTS[key] = nil

end

function love.focus(getFocus)
	if (not getFocus) then
		love.event.quit( )
	end
end

------------------------------------------------------------------------------------------------------
Tree = class(Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._currentHovered = nil

	self._grid = {}

end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:draw()
	for k,v in pairs(self._nodes) do
		v:draw()
	end

	if (self._currentHovered) then
		self._currentHovered:drawHovered()
	end
end

function Tree:registerInput()

end

function Tree:addNode(node)
	table.insert(self._nodes, node)
end
------------------------------------------------------------------------------------------------------
CairoTree = class(Tree, CairoTree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._width = 0
	self._height = 0

	self._currentHovered = nil

	self._grid = {}
end)

function CairoTree:initialzeToDimensions(width, height)
	local cairoConstructor = CairoPentagon

	self._grid = {}
	for x=1, width do
		self._grid[x] = {}
		for y=1, height do
			self._grid[x][y] = {}

			local node = cairoConstructor(GlobalTree)
			node:setPosition(x,y,1)
			local node = cairoConstructor(GlobalTree)
			node:setPosition(x,y,2)
		end
	end

	self._width = width
	self._height = height
end

function CairoTree:registerInput()
	local mouseX, mouseY = love.mouse.getPosition()

	local worldX = (mouseX - CAMOFFSET.X) / CAMOFFSET.ZOOM
	local worldY = (mouseY - CAMOFFSET.Y) / CAMOFFSET.ZOOM

	local gridPosX = worldX/self.size*.5
	local gridPosY = worldY/self.size*.5

	local gridX = math.floor(gridPosX) +1
	local gridY = math.floor(gridPosY) +1

	if  (gridX < 1 or gridX > self._width
		or gridY < 1 or gridY > self._height) then
		self._currentHovered = nil
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

	self._currentHovered = self._grid[gridX][gridY][zOffset]
end

function CairoTree:addToGrid(cairoPentagon,x,y,z)
	self._grid[x][y][z] = cairoPentagon
end


------------------------------------------------------------------------------------------------------
Node = class(Node, function(self, tree)
	self._vertices = nil
	self._edges = nil

	self._tree = tree
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
		for i=1, #self._edges do
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

------------------------------------------------------------------------------------------------------
CairoPentagon = class(Node, CairoPentagon, function(self, tree)

	self._tree = tree
	tree:addNode(self)
end)

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

	self._tree:addToGrid(self, gridX, gridY, gridZ)

	local scale = self._tree.size

	local isVertical = ((gridX + gridY) % 2 == 0)

	local startX = (gridX-1) *2 *scale
	local startY = (gridY-1) *2 *scale

	-- local offset = 0
	local offset = scale*((math.sqrt(3)-1)*0.5)
	-- local offset = scale

	if (isVertical) then
		if (gridZ == 1) then
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
		if (gridZ == 1) then
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
