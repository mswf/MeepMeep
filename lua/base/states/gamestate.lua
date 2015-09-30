


GameState = class(GameState, function(self, gameStateManager)
	self._gameStateManager = gameStateManager
	gameStateManager:addState(self)

	--self.broadcaster = Broadcaster()
end)

function GameState:initialize()

end

function GameState:enter(transitionType)

end

function GameState:exit(transitionType)

end

function GameState:reset()

end
