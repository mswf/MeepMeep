
IngameInput = class(IngameInput, function(self, ingamestate, graph, cameraController)

	self._ingameState = ingamestate
	self._graph = graph


	self._currentSelectedNode	= nil
	self._currentHoveredNode	= nil

	self._currentSelectedUnit	= nil

	self._cameraController = cameraController

end)


function IngameInput:update(dt)
	self._cameraController:updateInput(dt)

	if (Input.keyUp(KeyCode["i"])) then
		if (self._currentSelectedNode) then
			debugEntity(self._currentSelectedNode.entity)
		end
	end

	local worldX, worldY, worldZ = self._cameraController:screenToWorldPosition(Input.getMousePosition())

	local nodeUnderMouse = self._graph:getNodeByWorldCoord(worldX, worldY)
	if (Engine.ui.isMouseHoveringOverAnyWindow) then
		nodeUnderMouse = nil
	end

	self:setHovered(nodeUnderMouse)
	if (Input.mouseDown(1)) then
		self:setSelected(nodeUnderMouse)
	end

	if (Input.keyDown(KeyCode.P)) then
		if (self._currentSelectedNode and self._currentHoveredNode) then
			self._currentPath = Graph.findPath(self._currentSelectedNode, self._currentHoveredNode)

			DebugDrawPath:clear()
			local curPath = self._currentPath
			for i=1, #curPath do
				if (curPath[i+1]) then
					local x1, y1 = curPath[i]:getWorldCenter()
					local x2, y2 = curPath[i+1]:getWorldCenter()

					DebugDrawPath:addLine2D(x1, y1, x2, y2, 11/255, 218/255, 206/255, 0.8)
				end
			end
		else
			Log.steb("Can't draw a path, either there's no currentSelected or no currentHovered")
		end
	end

	if (Input.mouse(3)) then
		if (self._currentSelectedNode) then
			local unit = self._currentSelectedNode:getCurrentSelectedUnit()
			if (unit) and (unit:mayMove()) then
				unit:moveToNode(self._currentHoveredNode)

				self:setSelected(nil)
			end
		end
	end

	self:drawDebug()
end

function IngameInput:setHovered(newHovered)
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

function IngameInput:setSelected(newSelected)
	if (self._currentSelectedNode == newSelected) and (newSelected ~= nil) then
		newSelected:onCycleSelected()
		return
	end

	if (newSelected) then
		if (self._currentSelectedNode) then
			local staySelected = self._currentSelectedNode:onSelectNew(newSelected)
			if (staySelected) then
				return
			end

			self._currentSelectedNode:onDeselected()
		end

		self._currentSelectedNode = newSelected
		self._currentSelectedNode:onSelected()
	else
		if (self._currentSelectedNode) then
			self._currentSelectedNode:onDeselected()
		end
		self._currentSelectedNode = nil
	end
end

function IngameInput:drawDebug()
	DebugDrawTriangle:clear()

	if (self._currentSelectedNode) then
		self._currentSelectedNode:drawSelected()
	end

	if (self._currentHoveredNode) then
		self._currentHoveredNode:drawHovered()
	end
end
