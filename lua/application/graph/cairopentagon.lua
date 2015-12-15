
require "lua/application/graph/node"

CairoPentagon = class(CairoPentagon, Node, function(self, tree)

	self._vertices = nil
	self._edges = nil

	self._tree = tree
	self.neighbours = {}
	self.hasNeighbour = {}

	tree:addNode(self)

	self._RANDCOLOR = {}
	self._RANDCOLOR[1] = math.random()*.5
	self._RANDCOLOR[2] = math.random()*.5
	self._RANDCOLOR[3] = math.random()*.5
	self._RANDCOLOR[4] = 1

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*.5+.5
	self._RANDCOLORLINE[2] = math.random()*.5+.5
	self._RANDCOLORLINE[3] = math.random()*.5+.5
	self._RANDCOLORLINE[4] = 1
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

function CairoPentagon:getGridPosition()
	return self.gridX, self.gridY, self.gridZ
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
