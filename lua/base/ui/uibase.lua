
if (Engine.ui.__UIInit == nil) then
	Engine.ui.__UIInit = Engine.ui.createWindow
	-- UiWindow.create = nil
end

UIBase = class(UIBase, function(self, uiManager, params)
	uiManager = uiManager or {}
	if (not uiManager._activeWindows) then
		uiManager = Log.warning("Creating UI " .. tostring(self) .. " as a global UI") or GlobalUIManager
	else
		uiManager = uiManager or Log.warning("Creating UI " .. tostring(self) .. " as a global UI") or GlobalUIManager
	end

	self._params = params or {}

	self.window = uiManager:getNewWindow()
	self.window.__owner = self

	self._uiManager = uiManager

	self.window.title = "UI Base"

	if (self.update ~= UIBase.update) then
		uiManager:registerUpdate(self.window)
	end
	if (self.onWindowResized ~= UIBase.onWindowResized) then
		self._uiManager:registerResize(self.window)
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
		self._uiManager:registerUpdate(self.window)
	end
	if (self.onWindowResized ~= UIBase.onWindowResized) then
		self._uiManager:registerResize(self.window)
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

function UIBase:onWindowResized(newWidht, newHeight)

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
