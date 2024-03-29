
require "lua/application/ingame/gridunit"


MovingGridUnit = class(MovingGridUnit, GridUnit, function(self, data)
	-- data = data or {}

	self._path = {}
	self._isMoving = false

	self._movementSpeed = data.movementSpeed or 1.0
	self._turnSpeed			=	data.turnSpeed or 0.25

	self.tooltipText = "Moving Grid Unit"
end)


function MovingGridUnit:moveToNode(targetNode)
	if (self._isMoving) then
		Log.steb("[MovingGridUnit] cannot change path while moving")
		return
	end

	self._path = Graph.findPath(self._currentNode, targetNode)
	-- the path starts with the node that the unit is already on
	table.remove(self._path)

	if (#self._path > 0) then
		self._isMoving = true
		self:_moveToNextNode()
	end
end

function MovingGridUnit:_moveToNextNode()
	local targetX, targetY = self._path[#self._path]:getWorldCenter()
	local curX, curY = self:getPosition()

	local angle
	do
		local xDiff = targetX - curX
		local yDiff = targetY - curY
		angle = math.atan2(yDiff, xDiff)* (1/(2*math.pi)) - .25
	end

	GlobalIngameState.tweener:new(.2, self, {
		["setRoll"]=angle
	})
	:setEasing("inSine")
	:addOnComplete(function()
		GlobalIngameState.tweener:new(0.5, self, {
			["setX"]=targetX, ["setY"]=targetY, ["setZ"]=0
		})
		:setEasing("inCubic")
		:addOnComplete(function()
			self:setCurrentNode(self._path[#self._path])
			table.remove(self._path)

			if (#self._path > 0) then
				self:_moveToNextNode()
			else
				self._isMoving = false
			end
		end)
	end)

end

function MovingGridUnit:mayMove()
	return false
end

function MovingGridUnit:update(dt)
	-- if (self._isMoving) then
	-- 	self._isMoving = false
	-- end
end
