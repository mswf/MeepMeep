

require "lua/application/ingame/movinggridunit"

Caravan = class(Caravan, MovingGridUnit)

function Caravan:initializeFromData(data)
	-- gameplay
	self.selectable = true
	self.mayStopSelection = true

	-- visuals
	caravanModel = Engine.getModel("objects/world/grid/caravan.obj");
	renderer = MeshRenderer()
	renderer:setModel(caravanModel)

	local caravanMaterial = Material();
	caravanMaterial:setDiffuseTexture("objects/snowman.png")
	-- caravanMaterial:setDiffuseColor(unpack(nodes[i]._RANDCOLOR))

	renderer:setMaterial(caravanMaterial)

	self:addComponent(renderer)


	self:setPitch(0.25)

	-- debugEntity(self)


end


function Caravan:onSelected()

end

function Caravan:onDeselected()

end

function Caravan:onSelectNew(newNode)
	self:moveToNode(newNode)

	return false
end

-- function Caravan:setTargetNode(node)
-- 	-- local targetX, targetY, targetZ =

-- 	GlobalIngameState.tweener:new(1.1*math.random()+3.9, gridEntity, {["setScaleX"]=1, ["setScaleY"]=1, ["setScaleZ"]=1}):setEasing("outBounce")
-- end
