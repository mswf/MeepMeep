Camera = class(Camera, Engine.baseCamera, function(self)
	self:setAspectRatio(Engine.ui.getScreenWidth()/Engine.ui.getScreenHeight())
	-- self:setProjectionType(self.ProjectionType.ORTHOGRAPHIC)
	Game.windowResizedSignal:add(self.onWindowResized, self)

end)

function Camera:__onReload()
	self:setAspectRatio(Engine.ui.getScreenWidth()/Engine.ui.getScreenHeight())
	-- self:setProjectionType(self.ProjectionType.ORTHOGRAPHIC)
	-- self:setAspectRatio(0.5)
	self:setProjectionType(self.ProjectionType.PERSPECTIVE)

end

createPrivateEnum(Camera, "ProjectionType",
"PERSPECTIVE",
"ORTHOGRAPHIC")

function Camera:setProjectionType(projectionType)
	if (Camera.ProjectionType[projectionType.name]) then
		self._base.setProjectionType(self, projectionType.name)
	else
		Log.error("[Camera] invalid projectionType: " .. tostring(projectionType))
	end
end

function Camera:onWindowResized(newWidth, newHeight)
	self:setAspectRatio(newWidth/newHeight)
end
