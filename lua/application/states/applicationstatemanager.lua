
require("lua/base/states/gamestate_manager")

require("lua/base/states/gamestate")

require("lua/application/states/mainmenu_state")
require("lua/application/states/ingame_state")

createEnum("Transitions",
	"BootInMainMenu",
	"MainMenuToGame",
	"GameToMainMenu"
)


ApplicationStateManager = class(ApplicationStateManager, GameStateManager, function(self)
	self._base.init(self)

	local mainMenuState = MainMenuState(self)
	local ingameState = IngameState(self)


	self:addState(mainMenuState)
	self:addState(ingameState)

	self:addTransition(mainMenuState, Transitions.MainMenuToGame, ingameState)

	self:addTransition(ingameState, Transitions.GameToMainMenu, mainMenuState)

	self:_setCurrentState(mainMenuState, Transitions.BootInMainMenu)
end)
