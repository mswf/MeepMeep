
require "lua/application/ui/ingame/ingame_ui"

IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:enter(transition, args)
	IngameUI(self.UIManager)

	Log.steb("we entered the ingame")


end

function IngameState:exit(transition, args)

end

function IngameState:update(dt)
	-- Log.steb("updating the IngameState")

end
