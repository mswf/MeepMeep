
CameraController = class(CameraController, Entity, function(self)


	local basePlate = Entity()


	self:addChild(basePlate);
	self._basePlate = basePlate;

	local camera = Camera()
	camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
	camera:makeActive()
	camera:setAspectRatio(Engine.window.getWidth()/Engine.window.getHeight())
	basePlate:addComponent(camera);
	do
		local debugRenderer = DebugRenderer()
		basePlate:addComponent(debugRenderer)
--[[
	-- euler
	debugRenderer:addLine(0,0,0, 2,0,0, 1,0,0)
	debugRenderer:addLine(0,0,0, 0,2,0, 0,1,0)
	debugRenderer:addLine(0,0,0, 0,0,2, 0,0,1)
]]--
		debugRenderer:setDrawPoints(true)

		debugRenderer:addLine(0,0,-1, 0,0.2,-0.7, 0,1,0)
		debugRenderer:addLine(0,0,-1, 0,-0.2,-0.7, 1,0,0)

		debugRenderer:addLine(0,0,-1, 0.2,0,-0.7, 1,0,0)
		debugRenderer:addLine(0,0,-1, -0.2,0,-0.7, 1,0,0)

		debugRenderer:addLine(0,0,0, 	0,	0,-1, 0,0,1)
	end

	do
		local debugRenderer = DebugRenderer()
		self:addComponent(debugRenderer)

	end

	self:setPosition(10,10,0);

	basePlate:setPosition(0,0,5);


	debugEntity(self)
	debugEntity(basePlate)

	self._mousePanDelay = 0
end)

function CameraController:__onReload()
	local debugRenderer = self.debugRenderer

	debugRenderer:addLine()
end

local MAX_MOUSE_PAN_DELAY = 0.5

local cameraMoveSpeed = 30
local panningSpacing = 30

function CameraController:updateInput(dt)
	-- if true then return end

	self:updateBorderPanning(dt)

	if (Input.binding("moveUp")) then
		self:addY(-cameraMoveSpeed*dt)
	end

	if (Input.binding("moveDown")) then
		self:addY(cameraMoveSpeed*dt)
	end

	if (Input.binding("moveLeft")) then
		self:addX(cameraMoveSpeed*dt)
	end

	if (Input.binding("moveRight")) then
		self:addX(-cameraMoveSpeed*dt)
	end


	self:updateCameraZoom(dt)
end

local m_min, m_max = math.min, math.max

function CameraController:updateBorderPanning(dt)
	local mousePanDelay = self._mousePanDelay
	local isMousePanning = false
	if (Input.isMouseInWindow and not Engine.ui.isMouseHoveringOverAnyWindow) then
		local sWidth, sHeight = Engine.window.getWidth(), Engine.window.getHeight()
		local mouseX, mouseY = Input.getMousePosition()

		local mousePanDelayFactor
		if (mousePanDelay < MAX_MOUSE_PAN_DELAY*.5) then
			mousePanDelayFactor = 0
		else
			mousePanDelayFactor = mousePanDelay/(MAX_MOUSE_PAN_DELAY*.5)
		end


		if (mouseX < panningSpacing) then
			isMousePanning = true
			self:addX(cameraMoveSpeed*dt*((mouseX / panningSpacing)*-1+1)*mousePanDelayFactor)
		end

		if ((mouseX) > (sWidth - panningSpacing)) then
			isMousePanning = true
			self:addX(-cameraMoveSpeed*dt*(((mouseX- sWidth) / panningSpacing)+1)*mousePanDelayFactor)
		end

		if (mouseY < panningSpacing) then
			isMousePanning = true
			self:addY(-cameraMoveSpeed*dt*((mouseY / panningSpacing)*-1+1)*mousePanDelayFactor)
		end

		if ((mouseY) > (sHeight - panningSpacing)) then
			isMousePanning = true
			self:addY(cameraMoveSpeed*dt*(((mouseY- sHeight) / panningSpacing)+1)*mousePanDelayFactor)
		end
	end

	if (isMousePanning == true) then
		mousePanDelay = mousePanDelay + dt
	else
		mousePanDelay = mousePanDelay - dt*2
	end

	self._mousePanDelay = m_min(m_max(mousePanDelay, 0),MAX_MOUSE_PAN_DELAY)
end

function CameraController:updateCameraZoom(dt)


end
