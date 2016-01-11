
require "lua/application/ingame/movinggridunit"

Family = class(Family, MovingGridUnit)

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
		self:setInitialNode(GlobalIngameState.caravan:getCurrentNode())

	else
		self:setInitialNode(GlobalIngameState.graph:getNodeByGridPos(data:getPosition()))
	end

	-- debugEntity(self)


end
