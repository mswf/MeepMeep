
require "lua/application/ui/mainmenu/mainmenu_ui"
require "lua/application/ui/test_ui"
require "lua/application/ui/option_ui"

MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)


createPrivateEnum(MainMenuState, "Events",
	"OpenOptions",
	"CloseOptions"
)

function MainMenuState:update(dt)
	-- Log.steb("updating the MainMenuState")

end

function MainMenuState:__onReload()
	Log.steb("MainMenuState reloaded")

	-- self.window.title = "Anything"

	-- Log.steb("changed broadcaster reload")
end

function MainMenuState:exit(transitionType, args)
	if (args.instruction == "NEWGAME") then
		GlobalData:createGameNew()
	elseif (args.instruction == "LOADGAME") then
		GlobalData:loadGame(args.saveHandle)
	else
		GlobalData:createGameNew()
	end
end

function MainMenuState:enter(transitionType, args)
	--self._mainMenuUI = MainMenuUI(self.UIManager)
	--self._optionUI = OptionUI(self.UIManager, {visible = false})
	--self._testUI = TestUI(self.UIManager, {title = "Test 1"})
end
