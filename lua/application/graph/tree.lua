
require "lua/application/graph/node"

Tree = class(Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._grid = {}

end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:drawGrid()
	DebugDraw:clear()
	for k,v in pairs(self._nodes) do
		v:drawEdges()
	end
end

function Tree:addNode(node)
	table.insert(self._nodes, node)
end

function Tree:getNodeByWorldCoord(worldX, worldY)
	Log.error("[TREE] implement getNodeByWorldCoord")
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
