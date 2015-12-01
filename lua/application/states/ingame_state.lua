
IngameState = class(IngameState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function IngameState:enter()

	Log.steb("we entered the ingame")


		local testWindow = Engine.ui.createWindow()
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

		local closeButton = testWindow:addButton("To main menu")
		closeButton.onPress = function()
			testWindow:close()

			GlobalStateManager:doTransition(Transitions.GameToMainMenu)
		end

		closeButton.width = 100

end

function IngameState:enter(transition, args)

end

function IngameState:exit(transition, args)

end

function IngameState:update(dt)
	-- Log.steb("updating the IngameState")

end
