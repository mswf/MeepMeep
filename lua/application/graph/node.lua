
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
	self._RANDCOLOR[4] = .8

	self._RANDCOLORLINE = {}
	self._RANDCOLORLINE[1] = math.random()*.2+.5
	self._RANDCOLORLINE[2] = math.random()*.2+.5
	self._RANDCOLORLINE[3] = math.random()*.2+.5
	self._RANDCOLORLINE[4] = .5

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
			-- love.graphics.setColor(unpack(self._RANDCOLORLINE))

			DebugDraw:addLine2D(unpack(edges[i]))

			-- love.graphics.line(unpack(edges[i]))

			-- love.graphics.setColor(unpack(self._RANDCOLOR))
			-- love.graphics.circle("fill", edges[i][1], edges[i][2], self._tree.size/5, 6)
		end
		self:drawHovered()
		-- love.graphics.polygon('fill', self._vertices)
	end
end


DEBUGSKIP = true


function Node:drawHovered()
	if (not DEBUGSKIP) then
		return
	end

	DEBUGSKIP = false


	if (self._vertices) then
		local v = self._vertices
		local num = #v

		for i=1, num, 2 do
			if (i + 1 < num) and not (i < 2) then
				DebugDrawTriangle:addTriangle2D(v[1],		v[2],
																				v[i],	v[i+1],
																				v[i+2],	v[i+3],
																				unpack(self._RANDCOLORLINE))
			end
		end

		-- love.graphics.setColor(unpack(self._RANDCOLORLINE))

		-- love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawSelected()
	local neighbours = self.neighbours

	for i=1, #neighbours do
		neighbours[i]:drawNeighbour()
	end

	if (self._vertices) then
		-- love.graphics.setColor(255,255,255,128)

		-- love.graphics.polygon('fill', self._vertices)
	end
end

function Node:drawNeighbour()
	if (self._vertices) then
		-- love.graphics.setColor(100,100,100,128)

		-- love.graphics.polygon('fill', self._vertices)
	end
end