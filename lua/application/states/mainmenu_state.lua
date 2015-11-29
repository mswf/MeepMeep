
require "lua/application/ui/mainmenu_ui"
require "lua/application/ui/test_ui"


MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

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

	self._testUI = TestUI(self.UIManager, {title = "Test 1"})
	self._testUI2 = TestUI(self.UIManager, {title = "Test 2"})



	local testEntity = Entity()

	testEntity.update = function(delta)
		Log.bobn(delta)
	end



end
