
require "lua/base/broadcaster"

GameState = class(GameState, function(self, gameStateManager)
	self._gameStateManager = gameStateManager

	self.broadcaster = Broadcaster()

	self.UITweener = Tweener()
end)

function GameState:initialize()

end

function GameState:baseUpdate(dt)
	self:update(dt)

	self.UITweener:update(dt)
end

function GameState:update(dt)
	--override this
end

function GameState:enter(transitionType)

end

function GameState:exit(transitionType)

end

function GameState:reset()

end
