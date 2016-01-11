
require "lua/application/ui/ingame/ingame_ui"
require "lua/application/ui/ingame/selection_ui"

require "lua/application/graph/cairotree"

require "lua/application/ingame/caravan"
require "lua/application/ingame/ingameinput"


IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

	GlobalIngameState = self
end)

function IngameState:enter(transition, args)
	Log.steb("we entered the ingame")

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

	local tree = CairoTree(0,0)

	tree:setSize(1)
	tree:initializeToDimensions(10, 10)


	self.graph = tree
	self.graph:drawGrid()
	-- self.graph:draw()

	Engine.importModel("objects/world/grid/cairoGrid.obj",2)
	Engine.importModel("objects/world/grid/caravan.obj",2)


	gridModel = Engine.getModel("objects/world/grid/cairoGrid.obj");

	local nodes = tree._nodes

	local gridParent = Entity()

	for i=1, #nodes do
		renderer = MeshRenderer()
		renderer:setModel(gridModel)

		local gridMaterial = Material();
		gridMaterial:setDiffuseTexture("objects/snowman.png")
		gridMaterial:setDiffuseColor(unpack(nodes[i]._RANDCOLOR))

		renderer:setMaterial(gridMaterial)

		local gridEntity = Entity()
		gridEntity:addComponent(renderer)
		lineEntity:addChild(gridParent)

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
		-- self.tweener:new(1.1*math.random()+3.9, gridEntity, {["setScaleX"]=1, ["setScaleY"]=1, ["setScaleZ"]=1}):setEasing("outBounce")
	end

	self.lineEntity = lineEntity

	GlobalCaravan = Caravan(nodes[50])

	-- GlobalNodes = nodes

	-- GlobalCaravan:moveToNode(GlobalNodes[25])

	self.input = IngameInput(self, self.graph)
end

function IngameState:exit(transition, args)
	self.lineEntity:setPosition(500,5000,500)
end

function IngameState:update(dt)
	self.input:update()
end
