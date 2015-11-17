
MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function MainMenuState:update(dt)
	-- Log.steb("updating the MainMenuState")
	if globalLabel ~= nil then
		globalLabel.text = "x: "..globalLabel.parent.x..", y: "..globalLabel.parent.y
	end
end

function MainMenuState:__onReload()
	Log.steb("MainMenuState reloaded")

	self.window.title = "Anything"

	-- Log.steb("changed broadcaster reload")
end


function MainMenuState:enter(transitionType)

	local testWindow = UiWindow.create()
	testWindow.x = 400
	testWindow.y = 400
	testWindow.height = 200
	testWindow.width = 200
	testWindow.resizable = true

	globalLabel = testWindow:addText("pls")

	testWindow:addButton("close", function()
		testWindow:close()
	end)

	TestAnim.UITweener = self.UITweener

	testWindow.onClose = function()
		globalLabel = nil
		local pls = UiWindow.create()
		pls.closable = false;
		pls:addText("can't close this")

		self.UITweener:new(4, pls, {y = 10}):setEasing(EasingFunctions.outBounce):addOnComplete(function(twn) TestAnim.moveDown(twn) end)
	end

end

TestAnim = TestAnim or {}

TestAnim.moveUp = function(previousTween)
	TestAnim.UITweener:new(4, previousTween.subject, {y = 10}):setEasing(EasingFunctions.outBounce):addOnComplete(TestAnim.moveDown)
end

TestAnim.moveDown = function(previousTween)
	TestAnim.UITweener:new(4, previousTween.subject, {y = 400}):setEasing(EasingFunctions.outBounce):addOnComplete(TestAnim.moveUp)
end
