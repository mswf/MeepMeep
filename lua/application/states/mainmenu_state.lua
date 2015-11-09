
MainMenuState = class(MainMenuState, GameState, function(self, gameStateManager)
	self._base.init(self, gameStateManager)

end)

function MainMenuState:update(dt)
	-- Log.steb("updating the MainMenuState")

end


function MainMenuState:enter(transitionType)

	local window = UiWindow.create("y", 200, 400)
	-- Log.bobn(window)
	-- Log.bobn(window.__coreProperties__)


	window.resizable = false;
	window.collapsable = false;
	window.closable = false;
	window.movable = false;
	window.x = 100;
	window.y = 400;
	window.title = "StebDaBes"

	window.someVar = 3
	window:addText(Parser.getString("TESTKEY"))
	window:addButton("Continue")

	window:addButton("New Game")

	local cooks = require "lua/application/credits"
	window:addText("CREDITS:")
	for i=1, #cooks do
		window:addText("")
		window:addText(cooks[i][1])
		window:addText(string.upper(cooks[i][2]))
	end


	-- UITweener:new(8, window, {y = 10}):setEasing(EasingFunctions.outBounce)

	self.UITweener:new(8, window, {y = 10}):setEasing(EasingFunctions.outBounce)



	self.UITweener:new(2, window, {x = 500}):addOnComplete(function(uiElement)
			self.UITweener:new(2, window, {x = 100}):addOnComplete(function(_)
				self.UITweener:new(2, window, {x = 500}):setEasing("outBounce"):addOnComplete(function(uiElement)
						self.UITweener:new(2, window, {x = 100}):setEasing("inBounce")
					end)
				end)
			end)

end
