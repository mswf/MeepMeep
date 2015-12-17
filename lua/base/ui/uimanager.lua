

UIManager = class(UIManager, function(self)
	self._activeWindows = {}

	self._updatingWindows = {}

	self.tweener = Tweener()
end)


function UIManager:getNewWindow()
	local window = Engine.ui.createWindow()

	self._activeWindows[window] = window

	return window
end

function UIManager:setVisible(isVisible)
	for k,v in pairs(self._activeWindows) do
		k.visible = isVisible
	end
end

function UIManager:registerUpdate(window)
	self._updatingWindows[window] = window.__owner or Log.warning("[UIManager] tried to registerUpdate a window without an '__owner' property")
end

function UIManager:update(dt)
	self.tweener:update(dt)

	for k, v in pairs(self._updatingWindows) do
		v:update(dt)
	end
end

function UIManager:removeWindow(uiWindow)
	if (self._activeWindows[uiWindow]) then
		self._updatingWindows[uiWindow] = nil
		self._activeWindows[uiWindow] = nil
		return true
	else
		return false
	end
end

function UIManager:destroyAll()
	self.tweener:clear()

	for i,v in pairs(self._activeWindows) do
		v.__owner:_cleanUp()
	end

	self._activeWindows = {}
	self._updatingWindows = {}
end
