
MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function MainMenuState:update(dt)
	-- Log.steb("updating the MainMenuState")
	if globalLabel ~= nil then
		local bobBes = "Bobn is not da bes"
		if checkbox.checked then
			bobBes = "Bobn is da best!";
		end
		globalLabel.text = "x: "..globalLabel.parent.x..", y: "..globalLabel.parent.y.."\n"..tostring(inputLabel.text).."\n"..bobBes.."\n"..(sliderA.value + sliderB.value).." cows"
	end
end

function MainMenuState:__onReload()
	Log.steb("MainMenuState reloaded")

	self.window.title = "Anything"

	-- Log.steb("changed broadcaster reload")
end


function MainMenuState:enter(transitionType)

	local testWindow = Engine.ui.createWindow()
	testWindow.x = 400
	testWindow.y = 100
	testWindow.height = 500
	testWindow.width = 400
	testWindow.resizable = false

	testWindow.title = "Main Menu"

	testWindow.expanded = false

	testWindow.onCollapse = function(window)
		Log.bobn("collapsed")
	end

	testWindow.onExpand = function(window)
		Log.bobn("expanded")
	end

	globalLabel = testWindow:addText("pls")

	local closeButton = testWindow:addButton("Start Game", function()
		Log.bobn("pls")

		testWindow:close()

		GlobalStateManager:doTransition(Transitions.MainMenuToGame)
	end)

	closeButton.tooltip = "This closes the window"

	testTree = testWindow:addTree("some tree")
	local treeText = testTree:addText("Text in the tree")
	local treeButton = testTree:addButton("TreeButton")

	testTree.tooltip = "This is a tree"
	treeText.tooltip = "even on text"

	testTestTree = testTree:addTree("more trees")
	treeText = testTestTree:addText("More text in the trees")

	inputLabel = testTestTree:addInputText("nerts", "wow")
	checkbox = testWindow:addCheckbox("Is bob da bes?", true)
	checkbox.tooltip = "The answer is yes"

	inputLabel.text = "pls"

	inputLabel.onFocusGain = function(inputText)
		if inputText.text == "pls" then
			inputText.text = ""
		end
		Log.bobn("focus gained: "..inputText.text)
	end

	inputLabel.onFocusLose = function(inputText)
		if inputText.text == "" then
			inputText.text = "pls"
		end
		--inputText.text = "lel"
	end

	inputLabel.onChange = function(inputText)
		checkbox.tooltip = "the answer is "..inputText.text
	end

	treeText.tooltip = "even on more text"

	treeButton.onPress = function(treeButton)
		treeButton.onPress = nil
		checkbox.checked = true
		checkbox:destroy()
		testTestTree:remove(treeText);
	end

	--testWindow.visible = false

	local otherTree = testWindow:addTree("another Tree")

	sliderA = otherTree:addSlider("floats")
	sliderA.minValue = 50
	sliderA.maxValue = 150
	sliderA.format = "%.2f"

	sliderB = otherTree:addSlider("ints")
	sliderB.minValue = -10
	sliderB.maxValue = 10
	sliderB.rounded = true
	sliderB.format = "%.0f cows"
	sliderB.value = 0

	TestAnim.UITweener = self.UITweener

	testWindow.onClose = function()
		-- globalLabel = nil
		-- local pls = UiWindow.create()
		-- pls.closable = false;
		-- pls:addText("can't close this")
		--
		-- self.UITweener:new(4, pls, {y = 10}):setEasing(EasingFunctions.outBounce):addOnComplete(function(twn) TestAnim.moveDown(twn) end)
	end

	local testRegion = testWindow:addRegion()
	for ii=1,99 do
		testRegion:addText("text - "..ii)
	end

	testRegion.width = -50
	testRegion.height = -100

	local testHori = testWindow:addHorizontalLayout()
	testHori:addButton("button a")
	local big = testHori:addButton("button b")
	big.width = 120
	testHori:addButton("button c")

	big.onHoverIn = function(button)
		button.text = "hovered"
	end

	big.onHoverOut = function(button)
		button.text = "not hovered"
	end

	testHori.spacing = 10;

	local sliderC = testWindow:addSlider("spacing")
	sliderC.minValue = 0
	sliderC.maxValue = 20
	sliderC.value = 10
	sliderC.rounded = true
	sliderC.format = "%.0f"

	sliderC.onChange = function(slider)
		testHori.spacing = slider.value
	end

end

TestAnim = TestAnim or {}

TestAnim.moveUp = function(previousTween)
	TestAnim.UITweener:new(4, previousTween.subject, {y = 10}):setEasing(EasingFunctions.outBounce):addOnComplete(TestAnim.moveDown)
end

TestAnim.moveDown = function(previousTween)
	TestAnim.UITweener:new(4, previousTween.subject, {y = 400}):setEasing(EasingFunctions.outBounce):addOnComplete(TestAnim.moveUp)
end
