
require "lua/base/broadcaster"

GameState = class(GameState, function(self, gameStateManager)
	self._gameStateManager = gameStateManager

	self.broadcaster = Broadcaster()

	self.tweener = Tweener()
	self.UIManager = UIManager()
end)

function GameState:initialize()

end

function GameState:__onReload()
	self:baseExit()

	self:baseEnter()
end

function GameState:baseUpdate(dt)
	self:update(dt)

	self.tweener:update(dt)
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

	self.tweener:clear()
	self.UIManager:destroyAll()

	collectgarbage()
end

function GameState:exit(transitionType, args)

end
