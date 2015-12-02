

MainMenuUI = class(MainMenuUI, UIBase)

-- initialize and create UI elements here
function MainMenuUI:_createUI()
	Log.steb("creating main menu")

	local window = self.window

	window.title = "Main Menu"

	window.height = 680
	window.width = 400

	window.x = 60
	window.y = 20

	window.displayTitle = false
	window.resizable = false
	window.movable = false

	local titleLayout = window:addHorizontalLayout()

	titleLayout.spacing = 250

	self.titleText = titleLayout:addText()
	local titleText = self.titleText

	titleText.text = "The Frontier"

	self.versionText = titleLayout:addText()
	local versionText = self.versionText
	versionText.text = "v a.1"

	self.introText = window:addText()
	local introText = self.introText
	introText.text = "     A WIP game by some idiots."

	local spacingStub = window:addText()

	spacingStub.text = ""

	local startGameButton = window:addButton()

	startGameButton.text = "Start Game"
	startGameButton.width = 200

	startGameButton.onPress = function()
		GlobalStateManager:doTransition(Transitions.MainMenuToGame, {instruction = "NEWGAME"})
	end

	local loadGameButton = window:addButton()

	loadGameButton.text = "Load Game"
	loadGameButton.width = 200

	loadGameButton.onPress = function()
		GlobalStateManager:doTransition(Transitions.MainMenuToGame, {instruction = "LOADGAME", saveHandle = "testsave"})
	end

	local openOptionsButton = window:addButton()

	openOptionsButton.text = "Options"
	openOptionsButton.width = 200

	openOptionsButton.onPress = function()
		local broadcaster = GlobalStateManager:getCurrentState().broadcaster
		broadcaster:broadcast(MainMenuState.Events.OpenOptions)

	end
	--[[
	]]--
end

-- register to various events
function MainMenuUI:_register()

end

-- unregister to various events
function MainMenuUI:_unregister()

end
