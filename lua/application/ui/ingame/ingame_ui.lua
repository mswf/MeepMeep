

-- Don't override the constructor!
IngameUI = class(IngameUI, UIBase)

-- initialize and create UI elements here
function IngameUI:_createUI()
	local window = self.window

	window.x = 10
	window.y = 10
	window.height = 400
	window.width = 300
	window.resizable = false
	window.closable = false
	window.movable = false
	window.collapsable = false

	-- window.title = "Ingame Menu"

	window.displayTitle = false

	local globalLabel = window:addText("we are in game now")

	local closeButton = window:addButton("To main menu")
	closeButton.onPress = function()
		GlobalStateManager:doTransition(Transitions.GameToMainMenu)
	end

	closeButton.width = 100

end

-- register to various events
function IngameUI:_register()

end

-- unregister to various events
function IngameUI:_unregister()

end

-- defining this function will cause instances to register themselves
--function IngameUI:update(dt)
--
--end
