
require "lua/application/ui/ingame/ingame_ui"


require "lua/application/graph/cairotree"

IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:enter(transition, args)
	IngameUI(self.UIManager)

	Log.steb("we entered the ingame")


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

	-- lineEntity:addChild(triangleEntity)
	lineEntity:addChild(pathEntity)
	lineEntity:setPosition(-10,-10,-10)

	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25, 0,0,0)
	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25,r,g,b)
	-- DebugDrawTriangle:addTriangle2D(0,0,25,25,0,25,r,g,b)


	EntityDebugUI(self.UIManager, {entity = lineEntity})

	local tree = CairoTree(0,0)

	tree:setSize(1)
	tree:initializeToDimensions(10,10)


	self.tree = tree
	self.tree:draw()
end

function IngameState:exit(transition, args)

end

function IngameState:update(dt)
	-- if (Input.mouseDown(3)) then
	-- 	Log.steb("2")
	-- end

	self.tree:registerInput()

	DebugDraw:clear()
	DebugDrawTriangle:clear()
	DebugDrawPath:clear()

	self.tree:draw()

	-- Log.steb("updating the IngameState")

end
