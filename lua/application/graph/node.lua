
-- require "lua/application/graph/tree"

Node = class(Node, function(self, tree)
	self._vertices = nil
	self._edges = nil

	self._tree = tree
	self.neighbours = {}
	self.hasNeighbour = {}


	tree:addNode(self)

	self._RANDCOLOR = {}
	self._RANDCOLOR[1] = math.random()*.2
	self._RANDCOLOR[2] = math.random()*.2
	self._RANDCOLOR[3] = math.random()*.2
	self._RANDCOLOR[4] = 0.8

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*.2+.5
	self._RANDCOLORLINE[2] = math.random()*.2+.5
	self._RANDCOLORLINE[3] = math.random()*.2+.5
	self._RANDCOLORLINE[4] = 1

	self._units = {}
end)

function Node:getTooltip()
	local tooltipText = "Tooltip for a Node"

	return tooltipText
end

function Node:addUnit(unit)
	self._units[#self._units + 1] = unit
end

function Node:removeUnit(unit)
	local units = self._units
	for i=1, #units do
		if (units[i] == unit) then
			table.remove(units, i)
			break
		end
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
																				unpack(self._RANDCOLOR))
			end
		end
	end
end

function Node:drawSelected()
	local neighbours = self.neighbours

	for i=1, #neighbours do
		neighbours[i]:drawNeighbour()
	end

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
		-- love.graphics.setColor(255,255,255,128)

		-- love.graphics.polygon('fill', self._vertices)
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
		-- love.graphics.setColor(100,100,100,128)

		-- love.graphics.polygon('fill', self._vertices)
	end
end

function Node:onHoverIn()

end

function Node:onHoverOut()

end
