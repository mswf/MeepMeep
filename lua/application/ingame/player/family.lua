
require "lua/application/ingame/movinggridunit"

Family = class(Family, MovingGridUnit)

Family.selectable = true

function Family:initializeFromData(data)
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

	self.tooltipText = data.familyName

	if (data:isInMainCaravan()) then
		-- TODO: hide visuals
		self:addToCaravan(GlobalIngameState.caravan)
		self:setInitialNode(GlobalIngameState.caravan:getCurrentNode())

	else
		self:removeFromCaravan()
		self:setInitialNode(GlobalIngameState.graph:getNodeByGridPos(data:getPosition()))
	end

	-- debugEntity(self)


end

function Family:addToCaravan(caravan)
	self.selectable = false
	self._currentCaravan = caravan

	caravan:addChild(self)

-- (callback, context, priority)
	caravan.onSetCurrentNode:add(self.setCurrentNode, self)
end

function Family:removeFromCaravan()
	self.selectable = true

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
