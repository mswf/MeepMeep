
IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:update(dt)
	-- Log.steb("updating the IngameState")

end
