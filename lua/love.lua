

LoveGame = LoveGame or {}
function love.load()
	LoveGame.nodes = {}

	GlobalTree = CairoTree(0,0)
	GlobalTree:setSize(40)

	for x=1,10 do
		for y=1,10 do
			local node = CairoPentagon(GlobalTree)
			node:setPosition(x,y,1)
			local node = CairoPentagon(GlobalTree)
			node:setPosition(x,y,2)
		end
	end
end

function love.update(dt)
	GlobalTree:registerInput()
end

CAMOFFSET = {}
CAMOFFSET.X = 0
CAMOFFSET.Y = 0


function love.draw()
	love.graphics.translate(CAMOFFSET.X, CAMOFFSET.Y)

	love.graphics.setColor(255,255,255)

  love.graphics.print("GwebSux", 400, 300)

	GlobalTree:draw()

end

function love.keypressed(k)
	local keyMagnitude = 10
	if (k == "w") then
		CAMOFFSET.Y =  CAMOFFSET.Y + keyMagnitude
	end

	if (k == "s") then
		CAMOFFSET.Y =  CAMOFFSET.Y - keyMagnitude
	end

	if (k == "a") then
		CAMOFFSET.X =  CAMOFFSET.X + keyMagnitude
	end

	if (k == "d") then
		CAMOFFSET.X =  CAMOFFSET.X - keyMagnitude
	end
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

	self._currentHovered = nil

	self._grid = {}
end)

function CairoTree:registerInput()
	local mouseX, mouseY = love.mouse.getPosition()

	mouseX = mouseX - CAMOFFSET.X
	mouseY = mouseY - CAMOFFSET.Y


	mouseX = mouseX/self.size*.5
	mouseY = mouseY/self.size*.5

	local gridX = math.floor(mouseX) +1
	local gridY = math.floor(mouseY) +1

	local isVertical = ((gridX + gridY) % 2 == 0)

	local zOffset = 1
	if (isVertical) then
		if (math.floor(mouseX) < math.round(mouseX)) then
			zOffset = 2
		end
	else
		if (math.floor(mouseY) < math.round(mouseY)) then
			zOffset = 2
		end
	end

	local grid = self._grid
	local newHovered = nil

	if (self._grid[gridX]) then
		if (self._grid[gridX][gridY]) then
			if (self._grid[gridX][gridY][zOffset]) then
				newHovered = self._grid[gridX][gridY][zOffset]
			end
		end
	end

	if (not newHovered) then
		self._currentHovered = nil
	else
		self._currentHovered = newHovered
	end
end

function CairoTree:addToGrid(cairoPentagon,x,y,z)
	if (not self._grid[x]) then
		self._grid[x] = {}
	end

	if (not self._grid[x][y]) then
		self._grid[x][y] = {}
	end

	self._grid[x][y][z] = cairoPentagon
end


------------------------------------------------------------------------------------------------------
Node = class(Node, function(self, tree)
	self._vertices = nil
	self._edges = nil

	self._tree = tree
	tree:addNode(self)

	self._RANDCOLOR = {}
	self._RANDCOLOR[1] = math.random()*255
	self._RANDCOLOR[2] = math.random()*255
	self._RANDCOLOR[3] = math.random()*255

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*255
	self._RANDCOLORLINE[2] = math.random()*255
	self._RANDCOLORLINE[3] = math.random()*255
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

			love.graphics.setColor(unpack(self._RANDCOLOR))
			love.graphics.circle("fill", edges[i][1], edges[i][2], self._tree.size/5, 6)
		end

		-- love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawHovered()
	if (self._vertices) then
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

DEBUGSKIPDRAW = true

function CairoPentagon:setPosition(gridX,gridY, gridZ)
	self.gridX = gridX
	self.gridY = gridY
	self.gridZ = gridZ

	self._tree:addToGrid(self, gridX, gridY, gridZ)

	local scale = self._tree.size

	local isVertical = ((gridX + gridY) % 2 == 0)

	local startX = (gridX-1) *2 *scale
	local startY = (gridY-1) *2 *scale


	if (isVertical) then
		if (gridZ == 1) then
			-- A
			-- if DEBUGSKIPDRAW then return end

			self:setVertices({
				{startX +scale,													startY +scale*2		- scale*((math.sqrt(3)-1)/2)},
				{startX,																startY +scale*2},
				{startX - scale*((math.sqrt(3)-1)/2),		startY +scale},
				{startX,																startY },
				{startX +scale,													startY 						+ scale*((math.sqrt(3)-1)/2)},

			})
		else
			-- B
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX+scale,													startY 						+ scale*((math.sqrt(3)-1)/2)},
				{startX+scale*2,											startY },
				{startX+scale*2+ scale*((math.sqrt(3)-1)/2),										startY + scale },
				{startX+scale*2,										startY +scale*2},
				{startX+scale,													startY +scale*2		- scale*((math.sqrt(3)-1)/2)},
			})
		end
	else
		if (gridZ == 1) then
			-- C
			-- if DEBUGSKIPDRAW then return end

			self:setVertices({
				{startX+ scale*((math.sqrt(3)-1)/2),					startY+scale},
				{startX,																			startY},
				{startX+scale,																startY- scale*((math.sqrt(3)-1)/2)},
				{startX+scale*2,															startY},
				{startX+scale*2- scale*((math.sqrt(3)-1)/2),	startY+scale},
			})
		else
			-- D
			-- if DEBUGSKIPDRAW then return end
			self:setVertices({
				{startX+scale*2- scale*((math.sqrt(3)-1)/2),	startY+scale},
				{startX+scale*2,															startY+scale+scale},
				{startX+scale,																startY+scale+scale+ scale*((math.sqrt(3)-1)/2)},
				{startX,																			startY+scale+scale},
				{startX+ scale*((math.sqrt(3)-1)/2),					startY+scale},

			})
		end
	end

end
