
require "lua/application/graph/node"

Tree = class(Tree, function(self, rootX, rootY)
	self.worldX = rootX
	self.worldY = rootY

	self._nodes = {}

	self.size = 1

	self._currentHovered = nil
	self._currentSelected = nil

	self._currentPath = {}

	self._grid = {}

end)

function Tree:setSize(newSize)
	self.size = newSize
end

function Tree:draw()


	if (self._currentSelected) then
		self._currentSelected:drawSelected()
	end

	if (self._currentHovered) then
		self._currentHovered:drawHovered()
	end

	for k,v in pairs(self._nodes) do
		v:draw()
	end

	local curPath = self._currentPath
	for i=1, #curPath do


		local x, y = curPath[i]:getWorldCenter()
		-- love.graphics.setColor(255,100,100,255)
		-- love.graphics.circle("fill",x,y , self.size/5, 6)

		if (curPath[i+1]) then
			local x1, y1 = curPath[i]:getWorldCenter()
			local x2, y2 = curPath[i+1]:getWorldCenter()

			DebugDrawPath:addLine2D(x1, y1, x2, y2)
			-- love.graphics.setColor(255,100,100,100)
			-- love.graphics.line(x1, y1, x2, y2)
		end


	end
end

function Tree:registerInput()

end

function Tree:addNode(node)
	table.insert(self._nodes, node)
end

function Tree:setHovered(newHovered)
	if (self._currentHovered == newHovered) then
		return
	end

	if (self._currentHovered) then

	end

	if (newHovered) then
		self._currentHovered = newHovered
		gridX, gridY, gridZ = newHovered:getGridPosition()
		Engine.ui.setTooltip(tostring(newHovered).. "\ngridX: " .. gridX .. "\ngridY: " .. gridY .. "\ngridZ: " .. gridZ)
	else
		self._currentHovered = nil
		Engine.ui.setTooltip("")
	end
end

function Tree:setSelected(newSelected)
	if (self._currentSelected == newSelected) then
		return
	end

	if (self._currentSelected) then

	end

	if (newSelected) then
		self._currentSelected = newSelected
	else
		self._currentSelected = nil
	end
end

function Tree:findPath(fromNode, toNode)
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
