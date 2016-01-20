
require "lua/application/ingame/movinggridunit"

Family = class(Family, MovingGridUnit, function(self, data)
	-- gameplay
	-- self.selectable = true
	-- self.mayStopSelection = true

	-- visuals
	caravanModel = Engine.getModel("objects/world/grid/caravan.obj");
	renderer = MeshRenderer()
	renderer:setModel(caravanModel)

	local caravanMaterial = Material();
	caravanMaterial:setDiffuseTexture("objects/snowman.png")
	caravanMaterial:setDiffuseColor(0.1,0.1,0.5,1)

	renderer:setMaterial(caravanMaterial)

	self:addComponent(renderer)
	self:setPitch(0.25)
	debugEntity(self)

	self.tooltipText = data.familyName

	if (data:isInMainCaravan()) then
		-- TODO: hide visuals
		-- self:setInitialNode(GlobalIngameState.caravan:getCurrentNode())
		self:addToCaravan(GlobalIngameState.caravan)

	else
		self:setInitialNode(GlobalIngameState.graph:getNodeByGridPos(data:getPosition()))
		self:removeFromCaravan()
	end

	-- debugEntity(self)

end)

Family.selectable = true

function Family:addToCaravan(caravan)
	self.selectable = false
	self._currentCaravan = caravan

	caravan:addChild(self)
	self:setPitch(0)

-- (callback, context, priority)
	caravan.onSetCurrentNode:add(self.setCurrentNode, self)
end

function Family:removeFromCaravan()
	self.selectable = true
	self:setPitch(0.25)

	if (self._currentCaravan) then
		self._currentCaravan:removeChild(self)
		caravan.onSetCurrentNode:remove(self)

		self._currentCaravan = nil
	end
end


function Family:mayMove()
	if (self._currentCaravan == nil) then
		return true
	else
		return false
	end
end

function Family:onSelected()

end

function Family:onDeselected()

end
