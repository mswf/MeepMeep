
-- require "lua/application/graph/tree"

local function rgb(r,g,b,a)
	a = a or 255
	return {r/255, g/255, b/255, a/255}
end

local sensibleColours = {}
sensibleColours[1] = rgb(111, 222, 122)
sensibleColours[2] = rgb(228, 170, 116)
sensibleColours[3] = rgb(35, 169, 245)
sensibleColours[4] = rgb(255, 255, 255)

Node = class(Node, function(self, tree)
	self._vertices = nil
	self._edges = nil

	self._tree = tree
	self.neighbours = {}
	self.hasNeighbour = {}

	tree:addNode(self)

	local colourIndex = math.random(#sensibleColours)

	-- self._RANDCOLOR = {}
	-- self._RANDCOLOR[1] = sensibleColours[colourIndex][1]
	-- self._RANDCOLOR[2] = sensibleColours[colourIndex][2]
	-- self._RANDCOLOR[3] = sensibleColours[colourIndex][3]
	-- self._RANDCOLOR[4] = 1
	--
	-- self._RANDCOLORHOVER = {}
	-- self._RANDCOLORHOVER[1] = sensibleColours[colourIndex][1]
	-- self._RANDCOLORHOVER[2] = sensibleColours[colourIndex][2]
	-- self._RANDCOLORHOVER[3] = sensibleColours[colourIndex][3]
	-- self._RANDCOLORHOVER[4] = .5
	--
	-- self._RANDCOLORLINE = {}
	-- self._RANDCOLORLINE[1] = math.random()*.5+.5
	-- self._RANDCOLORLINE[2] = math.random()*.5+.5
	-- self._RANDCOLORLINE[3] = math.random()*.5+.5
	-- self._RANDCOLORLINE[4] = 1

	self.tileType = TileTypes.Water;

	self._units = {}
end)

function Node:getTooltip()
	local tooltipText = "Tooltip for a Node"

	return tooltipText
end

function Node:addUnit(unit)
	self._units[#self._units + 1] = unit

	if (self._isSelected) then
		self:_changeSelectableUnits()
	end
end

function Node:removeUnit(unit)
	local units = self._units
	for i=1, #units do
		if (units[i] == unit) then
			table.remove(units, i)
			break
		end
	end

	-- self._changeSelectableUnits()
end

function Node:onSelected()
	self._isSelected = true

	self._currentSelectedIndex = 0
	self:_changeSelectableUnits(1)
end

function Node:getCurrentSelectedUnit()
	return self._currentSelectedUnit
end

function Node:_changeSelectableUnits(increment)
	local selectableUnits = {}

	local previousSelectedUnit = self._currentSelectedUnit

	local units = self._units
	for i=1, #units do
		if (units[i].selectable) then
			table.insert(selectableUnits, units[i])
		end
	end

	-- TODO: sort by priority
	self._selectableUnits = selectableUnits
	self._currentSelectedIndex = self._currentSelectedIndex	+ (increment or 0)

	if (#selectableUnits > 0) then
		if (self._currentSelectedIndex > #selectableUnits) then
			self._currentSelectedIndex = #selectableUnits
		end

		self._currentSelectedIndex = 1
		self._currentSelectedUnit = selectableUnits[self._currentSelectedIndex]
		if (self._currentSelectedUnit ~= previousSelectedUnit) and (previousSelectedUnit ~= nil) then
			previousSelectedUnit:onDeselected()
			self._currentSelectedUnit:onSelected()
		end
	end
end

function Node:onCycleSelected()
	self:_changeSelectableUnits(1)
	--[[
	local selectableUnits = self._selectableUnits
	local selectableUnitsCount = #selectableUnits

	if (selectableUnitsCount > 1) then
		self._currentSelectedUnit:onDeselected()

		self._currentSelectedIndex = self._currentSelectedIndex + 1
		if (self._currentSelectedIndex > selectableUnitsCount) then
			self._currentSelectedIndex = 1
		end
		self._currentSelectedUnit = selectableUnits[self._currentSelectedIndex]

		self._currentSelectedUnit:onSelected()
	end
	]]
end

function Node:onSelectNew(newNode)
	--[[
	if (OBJECT_THATS_CURRENTLY_ACTIVE) then
		OBJECT_THATS_CURRENTLY_ACTIVE:doaction()
		return true
	end
	]]

	if (self._currentSelectedUnit) then
		if (self._currentSelectedUnit.mayStopSelection) then
			return self._currentSelectedUnit:onSelectNew(newNode)
		end
	end

	return false
end

function Node:onDeselected()
	self._isSelected = nil

	self._selectableUnits = {}

	if (self._currentSelectedUnit) then
		self._currentSelectedUnit:onDeselected()
	end

end


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

function Node:drawEdges()
	if (self._vertices) then
		local edges = self._edges
		for i=1, #edges do
			DebugDraw:addLine2D(unpack(edges[i]))
		end
	end
end

function Node:drawHovered()
	-- if true then return end

	if (self._vertices) then
		local v = self._vertices
		local num = #v

		for i=3, num, 2 do
			if (i + 1 < num) then
				DebugDrawTriangle:addTriangle2D(v[1],		v[2],
																				v[i],	v[i+1],
																				v[i+2],	v[i+3],
																				0.5,0.5,0.5,0.5)
			end
		end
	end
end

function Node:drawSelected()
	local neighbours = self.neighbours

	-- for i=1, #neighbours do
	-- 	neighbours[i]:drawNeighbour()
	-- end

	if (self._vertices) then
		local v = self._vertices
		local num = #v

		for i=3, num, 2 do
			if (i + 1 < num) then
				DebugDrawTriangle:addTriangle2D(v[1],		v[2],
																				v[i],	v[i+1],
																				v[i+2],	v[i+3],
																				1,1,1,0.5)
			end
		end
	end
end

function Node:drawNeighbour()
	if (self._vertices) then
		local v = self._vertices
		local num = #v

		for i=3, num, 2 do
			if (i + 1 < num) then
				DebugDrawTriangle:addTriangle2D(v[1],		v[2],
																				v[i],	v[i+1],
																				v[i+2],	v[i+3],
																				1,1,1,0.2)
			end
		end
	end
end

function Node:onHoverIn()

end

function Node:onHoverOut()

end
