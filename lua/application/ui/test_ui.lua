


-- Don't override the constructor!
TestUI = class(TestUI, UIBase)

-- initialize and create UI elements here
function TestUI:_createUI()
	local testWindow = self.window

	-- local testWindow = Engine.ui.createWindow()
	testWindow.x = 600
	testWindow.y = 50
	testWindow.height = 500
	testWindow.width = 400
	testWindow.resizable = false

	testWindow.title = self._params.title

	testWindow.expanded = false

	testWindow.onCollapse = function(window)
		Log.bobn("collapsed")
	end

	testWindow.onExpand = function(window)
		Log.bobn("expanded")
	end

	self.globalLabel = testWindow:addText("pls")

	local closeButton = testWindow:addButton("Start Game" )

	closeButton.onPress =function()
		Log.bobn("pls")

		testWindow:close()

		GlobalStateManager:doTransition(Transitions.MainMenuToGame)
	end

	closeButton.tooltip = "This closes the window"

	testTree = testWindow:addTree("some tree")
	local treeText = testTree:addText("Text in the tree")
	local treeButton = testTree:addButton("TreeButton")

	testTree.tooltip = "This is a tree"
	treeText.tooltip = "even on text"

	testTestTree = testTree:addTree("more trees")
	treeText = testTestTree:addText("More text in the trees")

	local inputLabel = testTestTree:addInputText("nerts", "wow")
	local checkbox = testWindow:addCheckbox("Is bob da bes?", true)
	checkbox.tooltip = "The answer is yes"

	self.checkbox = checkbox

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

	self.inputLabel = inputLabel

	treeText.tooltip = "even on more text"

	treeButton.onPress = function(treeButton)
		treeButton.onPress = nil
		checkbox.checked = true
		checkbox:destroy()
		testTestTree:remove(treeText);
	end

	--testWindow.visible = false

	local otherTree = testWindow:addTree("another Tree")

	local sliderA = otherTree:addSlider("floats")
	sliderA.minValue = 50
	sliderA.maxValue = 150
	sliderA.format = "%.2f"

	self.sliderA = sliderA

	local sliderB = otherTree:addSlider("ints")
	sliderB.minValue = -10
	sliderB.maxValue = 10
	sliderB.rounded = true
	sliderB.format = "%.0f cows"
	sliderB.value = 0

	self.sliderB = sliderB

	testWindow.onClose = function()

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

-- set the properties for all UI elements here (called during hotreload)
function TestUI:_setUI()

end

-- register to various events
function TestUI:_register()

end

-- unregister to various events
function TestUI:_unregister()

end

function TestUI:update(dt)
	local bobBes = "Bobn is not da bes"
	if self.checkbox.checked then
		bobBes = "Bobn is da best!";
	end
	self.globalLabel.text = "x: "..self.globalLabel.parent.x..", y: "..self.globalLabel.parent.y.."\n"..tostring(self.inputLabel.text).."\n"..bobBes.."\n"..(self.sliderA.value + self.sliderB.value).." cows"
end
