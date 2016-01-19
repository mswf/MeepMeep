
require "lua/application/ui/ingame/ingame_ui"
require "lua/application/ui/ingame/selection_ui"

require "lua/application/graph/cairograph"

require "lua/application/ingame/player/caravan"
require "lua/application/ingame/player/family"

require "lua/application/ingame/ingameinput"
require "lua/application/ingame/cameracontroller"



IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

	GlobalIngameState = self
end)

function IngameState:enter(transition, args)
	Log.steb("we entered the ingame")

	local cameraController = CameraController()

	self._ingameUI = IngameUI(self.UIManager)
	self._selectionUI = SelectionUI(self.UIManager)

	local lineEntity = Entity()
	lineEntity:addComponent(DebugRenderer())

	DebugDraw = lineEntity.debugRenderer

	local triangleEntity = Entity()
	triangleEntity:addComponent(DebugRenderer())

	DebugDrawTriangle = triangleEntity.debugRenderer

	local pathEntity = Entity()
	pathEntity:addComponent(DebugRenderer())

	DebugDrawPath = pathEntity.debugRenderer

	DebugDrawPath:setDrawPoints(true)
	DebugDrawPath:setPointSize(10.0)

	lineEntity:addChild(triangleEntity)
	lineEntity:addChild(pathEntity)

	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25, 0,0,0)
	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25,r,g,b)
	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25,r,g,b)

	-- EntityDebugUI(self.UIManager, {entity = lineEntity})

	local tree = CairoGraph(0,0)

	tree:setSize(1)
	tree:initializeToDimensions(10, 10)


	self.graph = tree
	-- self.graph:drawGrid()

	Engine.importModel("objects/world/grid/cairoGrid.obj",2)
	Engine.importModel("objects/world/grid/caravan.obj",2)


	gridModel = Engine.getModel("objects/world/grid/cairoGrid.obj");

	local nodes = tree._nodes

	local gridParent = Entity()
	lineEntity:addChild(gridParent)

	local nodeCount = #nodes
	
	for i=1, nodeCount do
		renderer = MeshRenderer()
		renderer:setModel(gridModel)

		local gridMaterial = Material();
		gridMaterial:setDiffuseTexture("objects/snowman.png")
		gridMaterial:setDiffuseColor(unpack(nodes[i]._RANDCOLOR))

		renderer:setMaterial(gridMaterial)

		local gridEntity = Entity()
		gridEntity:addComponent(renderer)

		local worldX, worldY = nodes[i]:getWorldCenter()

		local gridX, gridY, gridZ = nodes[i]:getGridPosition()

		local isVertical = ((gridX + gridY) % 2 == 0)

		if (isVertical) then
			if (gridZ == 1) then
				gridEntity:setRoll(0.25)
			else
				gridEntity:setRoll(0.75)
			end
		else
			if (gridZ == 1) then
				gridEntity:setRoll(0.5)
			else
				gridEntity:setRoll(1)
			end
		end

		gridEntity:setPitch(0.25)
		gridEntity:setScale(1,1,1)

		-- TODO: dangerous, check if this link is smart!!!
		gridEntity.node = nodes[i]
		nodes[i].entity = gridEntity
		--

		gridEntity:setPosition(worldX, worldY, 0)
		gridParent:addChild(gridEntity)

		gridEntity:setScale(0,0,0)
		self.tweener:new(1.5*math.random()+5.9, gridEntity, {["setScale"]=1}):setEasing("outBounce")

		-- self.tweener:new(1.5*math.random()+5.9, gridEntity, {["setScaleX"]=1, ["setScaleY"]=1, ["setScaleZ"]=1}):setEasing("outBounce")
	end

	-- debugEntity(lineEntity)

	self.lineEntity = lineEntity

	local caravanData = GlobalData.playerData.playerCaravan

	self.caravan = Caravan(caravanData)

	local familiesData = GlobalData.playerData:getFamilies()
	local families = {}

	for i=1, #familiesData do
		families[i] = Family(familiesData[i])
	end
	self.families = families


	-- GlobalNodes = nodes

	-- GlobalCaravan:moveToNode(GlobalNodes[25])

	self.input = IngameInput(self, self.graph, cameraController)
end

function IngameState:exit(transition, args)

	self.lineEntity:destroy()
	self.caravan:destroy()

	for i=1, #self.families do
		self.families[i]:destroy()
	end
end

function IngameState:update(dt)
	self.input:update(dt)
end
