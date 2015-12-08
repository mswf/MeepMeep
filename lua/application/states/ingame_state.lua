
require "lua/application/ui/ingame/ingame_ui"


require "lua/application/graph/cairotree"

IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:enter(transition, args)
	IngameUI(self.UIManager)

	Log.steb("we entered the ingame")


	local lineEntity = Entity()
	lineEntity:setPosition(-10,-10,-10)
	lineEntity:addComponent(DebugRenderer())
	-- lineEntity.debugRenderer:addLine(0,0,0, 2,0,0, 1,0,0)
	-- lineEntity.debugRenderer:addLine(0,0,0, 0,2,0, 0,1,0)
	-- lineEntity.debugRenderer:addLine(0,0,0, 0,0,2, 0,0,1)

	DebugDraw = lineEntity.debugRenderer

	DebugDraw.addLine2D = function(self, x1, y1, x2, y2, r,g,b)
		self:addLine(x1, y1, 0, x2, y2, 0, r,g,b)
	end

	EntityDebugUI(self.UIManager, {entity = lineEntity})


	local tree = CairoTree(0,0)

	tree:setSize(1)
	tree:initializeToDimensions(10,10)

	tree:draw()

	self.tree = tree

end

function IngameState:exit(transition, args)

end

function IngameState:update(dt)
	-- Log.steb("updating the IngameState")

end
