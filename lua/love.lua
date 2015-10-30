

LoveGame = LoveGame or {}
function love.load()
	LoveGame.nodes = {}

	GlobalTree = Tree(0,0)
	GlobalTree:setSize(40)


	Log.steb("A")
	local node = CairoPentagon(GlobalTree)
	node:setPosition(1,1,1)

	Log.steb("B")
	local node = CairoPentagon(GlobalTree)
	node:setPosition(1,1,2)

	Log.steb("C")
	local node = CairoPentagon(GlobalTree)
	node:setPosition(2,1,1)

	Log.steb("D")
	local node = CairoPentagon(GlobalTree)
	node:setPosition(2,1,2)


	-- Log.steb("E")
	-- local node = CairoPentagon(GlobalTree)
	-- node:setPosition(1,2,1)
	--
	-- Log.steb("F")
	-- local node = CairoPentagon(GlobalTree)
	-- node:setPosition(1,2,2)
	--
	-- Log.steb("G")
	-- local node = CairoPentagon(GlobalTree)
	-- node:setPosition(2,2,1)
	--
	-- Log.steb("H")
	-- local node = CairoPentagon(GlobalTree)
	-- node:setPosition(2,2,2)

	-- for x=1,10 do
	-- 	for y=1,10 do
	-- 		local node = CairoPentagon(GlobalTree)
	-- 		node:setPosition(x,y)
	-- 	end
	-- end
end

function love.update(dt)

end

function love.draw()
	love.graphics.setColor(255,255,255)

  love.graphics.print("woop", 400, 300)

	GlobalTree:draw()

end

function love.keypressed(k)

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
end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:draw()
	for k,v in pairs(self._nodes) do
		v:draw()
	end
end

function Tree:addNode(node)
	table.insert(self._nodes, node)
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
			love.graphics.circle("fill", edges[i][1], edges[i][2], 6, 6)
		end

		-- love.graphics.polygon('fill', self._vertices)
	end
end

------------------------------------------------------------------------------------------------------
CairoPentagon = class(Node, CairoPentagon, function(self, tree)

	self._tree = tree
	tree:addNode(self)
end)

--|----|----|---------|

--|----|----|---------|
--|    |    |    C    |
--| A  | B  |---------|
--|    |    |    D    |
--|----|----|---------|
--|    A    |    /    |
--|---------| C  / D  |
--|    B    |    /    |
--|---------|----/----|

function CairoPentagon:setPosition(gridX,gridY, gridZ)
	local scale = self._tree.size

	local isVertical = ((gridX + gridY) % 2 == 0)

	local startX = (gridX-1) *2 *scale
	local startY = (gridY-1) *2 *scale


	if (isVertical) then
		if (gridZ == 1) then
			-- A
			self:setVertices({
				{startX,				startY },
				{startX +scale,	startY },
				{startX +scale,	startY +scale*2},
				{startX,				startY +scale*2},
				{startX,				startY +scale}
			})
		else
			-- B
			if true then return end
			self:setVertices({
				{startX+scale,				startY },
				{startX+scale +scale,	startY },
				{startX+scale +scale,	startY },
				{startX+scale +scale,	startY +scale*2},
				{startX+scale,				startY +scale*2}
			})
		end
	else
		if (gridZ == 1) then
			-- C
			self:setVertices({
				{startX,						startY},
				{startX+scale,			startY},
				{startX+scale*2,		startY},
				{startX+scale*2,		startY+scale},
				{startX,						startY+scale}
			})
		else
			-- D
			if true then return end
			self:setVertices({
				{startX,						startY+scale},
				{startX+scale*2,		startY+scale},
				{startX+scale*2,		startY+scale+scale},
				{startX+scale,			startY+scale+scale},
				{startX,						startY+scale+scale}
			})
		end
	end

end
