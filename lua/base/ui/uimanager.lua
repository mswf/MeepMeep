

UIManager = class(UIManager, function(self)
	self._activeWindows = {}

end)


function UIManager:getNewWindow()
	local window = Engine.ui.createWindow()

	self._activeWindows[window] = window

	return window
end

function UIManager:removeWindow(uiWindow)
	if (self._activeWindows[uiWindow]) then
		self._activeWindows[uiWindow] = nil
		return true
	else
		return false
	end
end

function UIManager:destroyAll()
	for i,v in ipairs(self._activeWindows) do
		v:_cleanUp()
	end

	self._activeWindows = {}
end
