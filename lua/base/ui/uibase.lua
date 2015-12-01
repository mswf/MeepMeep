
if (Engine.ui.__UIInit == nil) then
	Engine.ui.__UIInit = Engine.ui.createWindow
	-- UiWindow.create = nil
end

UIBase = class(UIBase, function(self, uiManager, params)
	uiManager = uiManager or Log.warning("Creating UI " .. tostring(self) .. " as a global UI") or GlobalUIManager

	self._params = params or {}

	self.window = uiManager:getNewWindow()
	self.window.__owner = self

	self._uiManager = uiManager

	self.window.title = "UI Base"

	if (self.update ~= UIBase.update) then
		uiManager:registerUpdate(self.window)
	end

	local params = self._params
	if (params["visible"] ~= nil) then
		self.window.visible = params["visible"]
	end

	self:_createUI()
	self:_register()
end)


function UIBase:destroy()
	self._uiManager:removeWindow(self)

	self:_cleanUp()
end

function UIBase:_cleanUp()
	self:_unregister()

	self.window:close()

	-- workaround for ui leak
	self.window.__owner = nil
	self.window = nil
end

function UIBase:__onReload()
	self:destroy()

	self.window = self._uiManager:getNewWindow()
	self.window.__owner = self
	if (self.update ~= UIBase.update) then
		uiManager:registerUpdate(self.window)
	end

	self:_createUI()
	self:_register()
end

function UIBase:_createUI()

end

function UIBase:_register()

end

function UIBase:_unregister()

end

function UIBase:update(dt)

end

--[[
UI_IMPLEMENTATION = class(UI_IMPLEMENTATION, UIBase)

function UI_IMPLEMENTATION:_createUI()

end

function UI_IMPLEMENTATION:_register()

end

function UI_IMPLEMENTATION:_unregister()

end

]]--
