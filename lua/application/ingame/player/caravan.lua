

require "lua/application/ingame/movinggridunit"

Caravan = class(Caravan, MovingGridUnit, function(self, data)
	-- gameplay
	self.selectable = true
	self.mayStopSelection = true

	-- visuals
	caravanModel = Engine.getModel("objects/world/grid/caravan.obj");
	renderer = MeshRenderer()
	renderer:setModel(caravanModel)

	local caravanMaterial = Material();
	caravanMaterial:setDiffuseTexture("objects/world/grid/caravan_D.png")
	-- caravanMaterial:setDiffuseColor(unpack(nodes[i]._RANDCOLOR))

	renderer:setMaterial(caravanMaterial)

	self:addComponent(renderer)

	self:setInitialNode(GlobalIngameState.graph:getNodeByGridPos(data:getPosition()))

	self:setPitch(0.25)

	self.tooltipText = "Player Caravan"

	-- debugEntity(self)
end)

function Caravan:onSelected()

end

function Caravan:onDeselected()

end

function Caravan:onSelectNew(newNode)
	-- self:moveToNode(newNode)

	return false
end

function Caravan:mayMove()
	return true
end

-- function Caravan:setTargetNode(node)
-- 	-- local targetX, targetY, targetZ =

-- 	GlobalIngameState.tweener:new(1.1*math.random()+3.9, gridEntity, {["setScaleX"]=1, ["setScaleY"]=1, ["setScaleZ"]=1}):setEasing("outBounce")
-- end
