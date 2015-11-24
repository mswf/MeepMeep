
if (UiWindow.__UIInit == nil) then
	UiWindow.__UIInit = UiWindow.create
	-- UiWindow.create = nil
end

UIBase = class(UIBase, function(self, uiManager)
	uiManager = uiManager or GlobalUIManager

	self.widget = uiManager:getNewWindow()

	self._uiManager = uiManager

	self.widget.title = "UI Base"

	self:_createUI()
	self:_setUI()
	self:_register()
end)


function UIBase:destroy()
	self._uiManager:removeWindow(self)

	self:_cleanup()
end

function UIBase:_cleanUp()
	self:unregister()
end

function UIBase:__onReload()
	self:_setUI()
end

function UIBase:_createUI()

end

function UIBase:_setUI()

end

function UIBase:_register()

end

function UIBase:_unregister()

end
