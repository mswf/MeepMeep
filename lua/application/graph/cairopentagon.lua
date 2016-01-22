
require "lua/application/graph/node"

CairoPentagon = class(CairoPentagon, Node)

function CairoPentagon:getTooltip()
	local gridX, gridY, gridZ = self:getGridPosition()

	local tooltipText = tostring(self).. "\ngridX: " .. gridX .. "\ngridY: " .. gridY .. "\ngridZ: " .. gridZ

	for i=1, #self._units do
		tooltipText = tooltipText .. "\n- " .. self._units[i].tooltipText
	end

	return tooltipText
end

function CairoPentagon:setWorldCenter(gridX, gridY, gridZ)
	local scale = self._tree.size
	local isVertical = ((gridX + gridY) % 2 == 0)

	local x, y = 0,0

	x = (gridX-1) * scale * 2
	y = (gridY-1) * scale * 2

	if (isVertical) then
		y = y + scale
		if (gridZ == 1) then
			x = x + scale*.5 - self._tree.offset/2
		else
			x = x + scale* 1.5 + self._tree.offset/2
		end
	else
		x = x + scale
		if (gridZ == 1) then
			y = y + scale *.5 - self._tree.offset/2
		else
			y = y + scale * 1.5 + self._tree.offset/2
		end
	end

	self.worldX = x
	self.worldY = y
end

function CairoPentagon:getWorldCenter()
	-- return 0, 0
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
	-- self.gridX = gridX
	-- self.gridY = gridY
	-- self.gridZ = gridZ

	self:setWorldCenter(gridX, gridY, gridZ)

	self:generateVertices(gridX,gridY, gridZ)
end

function CairoPentagon:getGridPosition()
	-- return self.gridX, self.gridY, self.gridZ
	return self._tree:getGridPositionFromNode(self)
end

function CairoPentagon:generateVertices(gridX,gridY, gridZ)
	-- if true then return end
	local scale = self._tree.size

	-- local gridX, gridY, gridZ = self:getGridPosition()

	local isVertical = ((gridX + gridY) % 2 == 0)

	local startX = (gridX-1) *2 *scale
	local startY = (gridY-1) *2 *scale

	local offset = self._tree.offset

	-- local offset = 0
	-- local offset = scale*((math.sqrt(3)-1)*0.5)
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
