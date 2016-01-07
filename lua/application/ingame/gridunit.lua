
GridUnit = class(GridUnit, Entity, function(self, currentNode, data)
	self:setPositionFromNode(currentNode)

	self:setCurrentNode(currentNode)

	self:initializeFromData(data)

	self.tooltipText = "Grid Unit"
end)

function GridUnit:initializeFromData(data)
	--
end

function GridUnit:setPositionFromNode(node, offset)
	-- Log.steb("set position calle!")
	offset = offset or self._Zoffset

	local x, y = node:getWorldCenter()

	self:setPosition(x, y, offset)
end

function GridUnit:setCurrentNode(node)
	if (self._currentNode) then
		self._currentNode:removeUnit(self)
	end

	self._currentNode = node

	node:addUnit(self)
end


--[[
SELECTABLE GRID UNIT

	self.selectable = true

function SELECTABLEUNIT:onSelected()

end

function SELECTABLEUNIT:onDeselected()

end


STOPSELECTION

	self.mayStopSelection = true

function STOPSELECTION:onSelectNew(newNode)

end


]]
