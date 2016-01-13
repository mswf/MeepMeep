
CameraController = class(CameraController, Entity, function(self)
	local camera = Camera()

	camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
	camera:makeActive()
	camera:setAspectRatio(Engine.window.getWidth()/Engine.window.getHeight())

	self:addComponent(camera);

	self:setPosition(-10,-10,-10)

	debugEntity(self)
end)


local cameraMoveSpeed = 30
local panningSpacing = 30

function CameraController:updateInput(dt)
	if (Input.isMouseInWindow) then
		local sWidth, sHeight = Engine.window.getWidth(), Engine.window.getHeight()
		local mouseX, mouseY = Input.getMousePosition()

		if (mouseX < panningSpacing) then
			self:addX(cameraMoveSpeed*dt*((mouseX / panningSpacing)*-1+1))
		end

		if ((mouseX) > (sWidth - panningSpacing)) then
			self:addX(-cameraMoveSpeed*dt*(((mouseX- sWidth) / panningSpacing)+1))
		end

		if (mouseY < panningSpacing) then
			self:addY(-cameraMoveSpeed*dt*((mouseY / panningSpacing)*-1+1))
		end

		if ((mouseY) > (sHeight - panningSpacing)) then
			self:addY(cameraMoveSpeed*dt*(((mouseY- sHeight) / panningSpacing)+1))
		end
	end

	if (Input.binding("moveUp")) then
		Log.steb("moving up")
		Log.steb(-cameraMoveSpeed*dt)
		self:addY(-cameraMoveSpeed*dt)
	end

	if (Input.binding("moveDown")) then
		Log.steb("moving down")

		self:addY(cameraMoveSpeed*dt)
	end

	if (Input.binding("moveLeft")) then
		self:addX(cameraMoveSpeed*dt)
	end

	if (Input.binding("moveRight")) then
		self:addX(-cameraMoveSpeed*dt)
	end

end
