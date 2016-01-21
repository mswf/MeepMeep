
require "lua/application/ingame/tiles"

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
	self._cameraController = cameraController
	self._ingameUI = IngameUI(self.UIManager)
	-- self._selectionUI = SelectionUI(self.UIManager)

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

	local tree = CairoGraph(0,0)

	local GRID_WIDTH, GRID_HEIGHT = 300,300
	local NODE_COUNT = 100

	tree:setSize(1)
	tree:initializeToDimensions(GRID_WIDTH, GRID_HEIGHT)

	self.graph = tree
	-- self.graph:drawGrid()

	Engine.importModel("objects/world/grid/cairoGrid.obj",2)
	Engine.importModel("objects/world/grid/caravan.obj",2)

	Engine.importTexture("objects/world/grid/grid_texture_D.png", true)
	Engine.importTexture("objects/world/grid/caravan_D.png", true)

	local gridModel = Engine.getModel("objects/world/grid/cairoGrid.obj");

	local nodes = tree._nodes

	Log.steb("Start Generation")

	local currentNode = tree:getNodeByGridPos(math.random(GRID_WIDTH/2-5,GRID_WIDTH/2+5),math.random(GRID_HEIGHT/2-5,GRID_HEIGHT/2+5),math.random(1,2))

	local startNode = currentNode

	local T_TYPES = TileTypes
	local T_TYPES_GRASS = T_TYPES.Grassland

	for i=1, NODE_COUNT do

		currentNode.tileType = T_TYPES_GRASS;
		local currentNodeNeighbours = currentNode.neighbours

		local nextNode = currentNodeNeighbours[math.random(1, #currentNode.neighbours)]
		if (nextNode.tileType == T_TYPES_GRASS) then
			nextNode = currentNodeNeighbours[math.random(1, #currentNode.neighbours)]
		end

		local prevNode = currentNode

		currentNode = nextNode


		for i=1, #prevNode.neighbours do
			prevNode.neighbours[i].tileType = TileTypes.Grassland;

			for j=1, #prevNode.neighbours[i].neighbours do
				if (prevNode.neighbours[i].neighbours[j].tileType ~= TileTypes.Grassland) then
					prevNode.neighbours[i].neighbours[j].tileType = TileTypes.Arid;
				end
			end
		end
	end

	local gridParent = Entity()
	lineEntity:addChild(gridParent)

	local nodeCount = GRID_WIDTH * GRID_HEIGHT * 2

	for i=1, nodeCount do
		if (nodes[i].tileType == TileTypes.Water) then

		else
			renderer = MeshRenderer()
			renderer:setModel(gridModel)

			local gridMaterial = Material();
			gridMaterial:setDiffuseTexture("objects/world/grid/grid_texture_D.png")
			gridMaterial:setDiffuseColor(unpack(nodes[i].tileType.color))

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
			-- gridEntity.node = nodes[i]
			-- nodes[i].entity = gridEntity
			--

			gridEntity:setPosition(worldX, worldY, 0)
			gridParent:addChild(gridEntity)

			-- gridEntity:setScale(0,0,0)
			-- self.tweener:new(1.5*math.random()+5.9, gridEntity, {["setScale"]=1}):setEasing("outBounce")

			-- self.tweener:new(1.5*math.random()+5.9, gridEntity, {["setScaleX"]=1, ["setScaleY"]=1, ["setScaleZ"]=1}):setEasing("outBounce")
		end
	end

	-- debugEntity(lineEntity)

	self.lineEntity = lineEntity

	local caravanData = GlobalData.playerData.playerCaravan
	caravanData:setPosition(startNode:getGridPosition())
	self.caravan = Caravan(caravanData)

	cameraController:setPosition(startNode:getWorldCenter())


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
	self._cameraController:destroy()

	self.lineEntity = nil
	self.caravan = nil
	self._cameraController = nil


	for i=1, #self.families do
		self.families[i]:destroy()
	end
	self.families = nil

	self.input = nil

	self.graph = nil


	DebugDraw	=	nil
	DebugDrawTriangle	=	nil
	DebugDrawPath	=	nil
end

function IngameState:update(dt)
	self.input:update(dt)
end
