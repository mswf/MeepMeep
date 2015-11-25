
IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:enter()

	Log.steb("we entered the ingame")


		local testWindow = UiWindow.create()
		testWindow.x = 10
		testWindow.y = 10
		testWindow.height = 400
		testWindow.width = 300
		testWindow.resizable = false
		testWindow.closable = false
		testWindow.movable = false
		testWindow.collapsable = false


		-- testWindow.title = "Ingame Menu"

		testWindow.displayTitle = false

		globalLabel = testWindow:addText("we are in game now")

		local closeButton = testWindow:addButton("To main menu", function()
			testWindow:close()

			GlobalStateManager:doTransition(Transitions.GameToMainMenu)
		end)

		closeButton.width = 500

end

function IngameState:update(dt)
	-- Log.steb("updating the IngameState")

end
