
require "lua/application/graph/node"

Tree = class(Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._currentHoveredNode = nil
	self._currentSelectedNode = nil

	self._currentPath = {}

	self._grid = {}

end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:draw()
	DebugDrawTriangle:clear()

	if (self._currentSelectedNode) then
		self._currentSelectedNode:drawSelected()
	end

	if (self._currentHoveredNode) then
		self._currentHoveredNode:drawHovered()
	end
end

function Tree:drawGrid()
	DebugDraw:clear()
	for k,v in pairs(self._nodes) do
		v:drawEdges()
	end
end

function Tree:registerInput()

end

function Tree:addNode(node)
	table.insert(self._nodes, node)
end

function Tree:setHovered(newHovered)
	if (self._currentHoveredNode == newHovered) then
		return
	end

	if (self._currentHoveredNode) then
		self._currentHoveredNode:onHoverOut()
	end

	if (newHovered) then
		self._currentHoveredNode = newHovered
		self._currentHoveredNode:onHoverIn()

		-- gridX, gridY, gridZ = newHovered:getGridPosition()
		-- tostring(newHovered).. "\ngridX: " .. gridX .. "\ngridY: " .. gridY .. "\ngridZ: " .. gridZ

		Engine.ui.setTooltip(newHovered:getTooltip())
	else
		self._currentHoveredNode = nil
		Engine.ui.setTooltip("")
	end
end

function Tree:setSelected(newSelected)
	if (self._currentSelectedNode == newSelected) then
		return
	end

	if (self._currentSelectedNode) then

	end

	if (newSelected) then
		self._currentSelectedNode = newSelected

		self._currentSelectedNode:drawSelected()

	else
		self._currentSelectedNode = nil
	end
end

function Tree.findPath(fromNode, toNode)
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
