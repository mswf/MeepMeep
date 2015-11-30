
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


function MainMenuState:enter(transitionType)
	self._mainMenuUI = MainMenuUI(self.UIManager)

	self._optionUI = OptionUI(self.UIManager, {visible = false})

	self._testUI2 = TestUI(self.UIManager, {title = "Test 2"})
	self._testUI = TestUI(self.UIManager, {title = "Test 1"})

	local testEntity = Entity()

	Log.bobn("plsdfff")
	testEntity.update = function(delta)
		
	end



end
