

-- Don't override the constructor!
OptionUI = class(OptionUI, UIBase)

-- initialize and create UI elements here
function OptionUI:_createUI()
	local window = self.window

	window.title = "Options"

	window.x = 500
	window.y = 20

	window.movable = false
	window.closable = false

	local button = window:addButton()
	button.text = "close options"
	button.onPress = function ()
		local broadcaster = GlobalStateManager:getCurrentState().broadcaster
		broadcaster:broadcast(MainMenuState.Events.CloseOptions)

	end
end

function OptionUI:setVisible(isVisible)
	if (isVisible == true) then
		self.window.visible = isVisible
	else
		self.window.visible = isVisible
	end
end

-- register to various events
function OptionUI:_register()
	local broadcaster = GlobalStateManager:getCurrentState().broadcaster
	broadcaster:register(self, MainMenuState.Events.OpenOptions, function(self) self:setVisible(true) end)
	broadcaster:register(self, MainMenuState.Events.CloseOptions, function(self) self:setVisible(false) end)

end

-- unregister to various events
function OptionUI:_unregister()
	local broadcaster = GlobalStateManager:getCurrentState().broadcaster
	broadcaster:unregister(self, MainMenuState.Events.OpenOptions)
	broadcaster:unregister(self, MainMenuState.Events.CloseOptions)


end

-- defining this function will cause instances to register themselves
--function OptionUI:update(dt)
--
--end
