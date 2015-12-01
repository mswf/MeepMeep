
require "lua/base/broadcaster"

GameState = class(GameState, function(self, gameStateManager)
	self._gameStateManager = gameStateManager

	self.broadcaster = Broadcaster()

	self.UITweener = Tweener()
	self.UIManager = UIManager()
end)

function GameState:initialize()

end

function GameState:baseUpdate(dt)
	self:update(dt)

	self.UITweener:update(dt)
	self.UIManager:update(dt)
end

function GameState:update(dt)
	--override this
end

function GameState:baseEnter(transitionType, args)
	self:enter(transitionType, args)
end

function GameState:enter(transitionType, args)

end

function GameState:baseExit(transitionType, args)
	self:exit(transitionType, args)

	self.UITweener:clear()
	self.UIManager:destroyAll()
end

function GameState:exit(transitionType, args)

end
