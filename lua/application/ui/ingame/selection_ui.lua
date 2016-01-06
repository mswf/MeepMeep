

-- Don't override the constructor!
SelectionUI = class(SelectionUI, UIBase)

-- initialize and create UI elements here
function SelectionUI:_createUI()
	local window = self.window

	window.resizable = false
	window.closable = false
	window.movable = false
	window.collapsable = false
	window.displayTitle = false

	self:onWindowResized(Engine.window.getWidth(), Engine.window.getHeight())
end

-- register to various events
function SelectionUI:_register()

end

-- unregister to various events
function SelectionUI:_unregister()

end

-- defining this function will cause instances to register themselves
--function SelectionUI:update(dt)
--
--end

local SELECTIONUIHEIGHT = 150
function SelectionUI:onWindowResized(newWidth, newHeight)
	local window = self.window

	window.height = SELECTIONUIHEIGHT
	window.y = newHeight - SELECTIONUIHEIGHT + 10

	window.x = -10
	window.width = 500
end
