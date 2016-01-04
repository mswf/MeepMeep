
require "lua/application/ingame/gridunit"


MovingGridUnit = class(MovingGridUnit, GridUnit, function(self, currentNode, data)
	data = data or {}

	self:setPositionFromNode(currentNode)

	self._path = {}
	self._isMoving = false

	self._movementSpeed = data.movementSpeed or 1.0
	self._turnSpeed			=	data.turnSpeed or 0.25

	self:setCurrentNode(currentNode)

	self:initializeFromData(data)

	self.tooltipText = "Moving Grid Unit"
end)


function MovingGridUnit:moveToNode(targetNode)
	if (self._isMoving) then
		Log.steb("[MovingGridUnit] cannot change path while moving")
		return
	end

	self._path = Tree.findPath(self._currentNode, targetNode)

end

function MovingGridUnit:update(dt)
	-- Log.steb("moving grid updating!!")
end
