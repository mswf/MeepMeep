

MainMenuUI = class(MainMenuUI, UIBase)

-- initialize and create UI elements here
function MainMenuUI:_createUI()
	Log.steb("creating main menu")
	local window = self.window


end

-- set the properties for all UI elements here (called during hotreload)
local getCreateUI = UIBase._getOrCreateUI
function MainMenuUI:_setUI()
	local window = self.window

	window.title = "Main Menu"

	window.height = 680
	window.width = 400

	window.x = 60
	window.y = 20

	window.displayTitle = false
	window.resizable = false
	window.movable = false

	local titleLayout = getCreateUI(self, "titleLayout",
		function() return window:addHorizontalLayout() end)

	-- if (not self.titleLayout) then
	-- 	self.titleLayout = window:addHorizontalLayout()
	-- end
	-- local titleLayout = self.titleLayout
	titleLayout.spacing = 250

	if (not self.titleText) then
		self.titleText = titleLayout:addText()
	end
	local titleText = self.titleText
	titleText.text = "The Frontier"


	if (not self.versionText) then
		self.versionText = titleLayout:addText()
	end
	local versionText = self.versionText
	versionText.text = "v a.1"

	if (not self.introText) then
		self.introText = window:addText()
	end
	local introText = self.introText
	introText.text = "     A WIP game by some idiots."

	local spacingStub = getCreateUI(self, "spacingStub",
		function() return window:addText() end)

	spacingStub.text = ""

	local startGameButton = getCreateUI(self, "startGameButton",
		function() return window:addButton() end)

	startGameButton.text = "Start Game"
	startGameButton.width = 200
	-- startGameButton.height = 50

	startGameButton.onPress = function()
		GlobalStateManager:doTransition(Transitions.MainMenuToGame)
	end


end

-- register to various events
function MainMenuUI:_register()

end

-- unregister to various events
function MainMenuUI:_unregister()

end
