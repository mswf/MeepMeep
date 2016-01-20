
CameraController = class(CameraController, Entity, function(self)


	local basePlate = Entity()
	-- basePlate:setPitch(0.5);
	-- basePlate:setRoll(0.5);
	basePlate:setYaw(0.5);



	self:addChild(basePlate);
	self._basePlate = basePlate;
	self:setPosition(10,10,0);

	local camera = Camera()
	camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
	camera:setAspectRatio(Engine.window.getWidth()/Engine.window.getHeight())
	camera:setFOV(28)
	camera:setFarPlaneDistance(100)


	camera:makeActive()

	basePlate:addComponent(camera);
	if (false) then
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


		debugRenderer:addLine(0,1,0, 1,0,0, 1,1,1)
		debugRenderer:addLine(1,0,0, 0,-1,0, 1,1,1)
		debugRenderer:addLine(0,-1,0, -1,0,0, 1,1,1)
		debugRenderer:addLine(-1,0,0, 0,1,0, 1,1,1)

		-- debugRenderer:addLine(-50,0,0, 50,0,0, 1,1,1,.5)

	end



	-- debugEntity(basePlate, "Camera")
	-- debugEntity(self, "CameraFocus", true)

	self._mousePanDelay = 0
	self:_setZoomLevel(1)

	-- basePlate:setPosition(0,-3.77,53.5);
	-- basePlate:setPitch(-0.02);
	-- basePlate.camera:setFOV(80);
	--
	-- self:setPosition(33,26)
end)

function CameraController:onDestroy()
	Game.windowResizedSignal:remove(self._basePlate.camera)
end

function CameraController:__onReload()
	-- local debugRenderer = self.debugRenderer
	self._basePlate.camera:makeActive()
	self:_setZoomLevel(self._currentZoomLevel)
end

function CameraController:setBounds(width, height)

end


local cast_ray = Engine.raycaster.castRay

function CameraController:screenToWorldPosition(windowX, windowY)
	-- if true then return 0,0,0 end

	local dirX, dirY, dirZ = self._basePlate.camera:screenToWorldDirection(windowX, windowY)

	local camWorldX, camWorldY, camWorldZ = self._basePlate:getPosition()

	local MAGIC_DISTANCE_VAR = 0

	local worldX, worldY, worldZ = cast_ray(camWorldX, camWorldY, camWorldZ , dirX, dirY, dirZ, 0,0,1, MAGIC_DISTANCE_VAR)
	-- local worldX, worldY, worldZ = cast_ray(camWorldX, camWorldY, camWorldZ , dirX, dirY, dirZ, 0,0,1, 10)

--[[
	local debugRenderer = DebugDraw
	debugRenderer:clear()

	debugRenderer:addLine(camWorldX, camWorldY, camWorldZ , worldX, worldY, worldZ, 1,1,1)

	local C_OFFSET = 1
	debugRenderer:addLine(worldX+C_OFFSET, worldY, worldZ , worldX, worldY, worldZ, 0,0,0)
	debugRenderer:addLine(worldX-C_OFFSET, worldY, worldZ , worldX, worldY, worldZ, 0,0,0)
	debugRenderer:addLine(worldX, worldY+C_OFFSET, worldZ , worldX, worldY, worldZ, 0,1,0)
	debugRenderer:addLine(worldX, worldY-C_OFFSET, worldZ , worldX, worldY, worldZ, 0,0,0)
--]]
return worldX, worldY, worldZ

end

local MAX_MOUSE_PAN_DELAY = 0.5

local cameraMoveSpeed = 30
local panningSpacing = 30

function CameraController:updateInput(dt)
	-- if true then return end

	self:updateBorderPanning(dt)

	if (Input.binding("moveUp")) then
		self:addY(cameraMoveSpeed*dt)
	end

	if (Input.binding("moveDown")) then
		self:addY(-cameraMoveSpeed*dt)
	end

	if (Input.binding("moveLeft")) then
		self:addX(-cameraMoveSpeed*dt)
	end

	if (Input.binding("moveRight")) then
		self:addX(cameraMoveSpeed*dt)
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
			self:addX(-cameraMoveSpeed*dt*((mouseX / panningSpacing)*-1+1)*mousePanDelayFactor)
		end

		if ((mouseX) > (sWidth - panningSpacing)) then
			isMousePanning = true
			self:addX(cameraMoveSpeed*dt*(((mouseX- sWidth) / panningSpacing)+1)*mousePanDelayFactor)
		end

		if (mouseY < panningSpacing) then
			isMousePanning = true
			self:addY(cameraMoveSpeed*dt*((mouseY / panningSpacing)*-1+1)*mousePanDelayFactor)
		end

		if ((mouseY) > (sHeight - panningSpacing)) then
			isMousePanning = true
			self:addY(-cameraMoveSpeed*dt*(((mouseY- sHeight) / panningSpacing)+1)*mousePanDelayFactor)
		end
	end

	if (isMousePanning == true) then
		mousePanDelay = mousePanDelay + dt
	else
		mousePanDelay = mousePanDelay - dt*2
	end

	self._mousePanDelay = m_min(m_max(mousePanDelay, 0),MAX_MOUSE_PAN_DELAY)
end



local ZOOM_DURATION_IN = .5
local ZOOM_DURATION_OUT = .65


function CameraController:updateCameraZoom(dt)
	local _, mouseWheelScroll = Input.getMouseWheelScroll();

	if (mouseWheelScroll ~= 0) then
		if (self._currentTween) then
			GlobalIngameState.tweener:removeActiveTween(self._currentTween)
			self._currentTween = nil
		end

		self:_addZoomLevel(mouseWheelScroll*dt*-5)
	end
----[[
	if (Input.keyDown(KeyCode.z)) then
		local curZoom = self._currentZoomLevel
		if (self._currentTween) then
			GlobalIngameState.tweener:removeActiveTween(self._currentTween)
			self._currentTween = nil
		end
		if (curZoom == 1) then
			return
		end
		self._currentTween = GlobalIngameState.tweener(ZOOM_DURATION_OUT*(1-curZoom), self, {}):addOnUpdate(function(tween, dt, ratio)
			self:_setZoomLevel(curZoom+ratio*(1-curZoom))
		end):setEasing("outBack")
	end
	if (Input.keyDown(KeyCode.x)) then
		local curZoom = self._currentZoomLevel

		if (self._currentTween) then
			GlobalIngameState.tweener:removeActiveTween(self._currentTween)
			self._currentTween = nil
		end

		if (curZoom == 0) then
			return
		end
		self._currentTween = GlobalIngameState.tweener(ZOOM_DURATION_IN*(curZoom), self, {}):addOnUpdate(function(tween, dt, ratio)
			self:_setZoomLevel(curZoom-ratio*(curZoom))
		end):setEasing("inOutCubic")

	end
--]]
end
local math_min, math_max, math_lerp = math.min, math.max, math.lerp

function CameraController:_addZoomLevel(deltaZoomLevel)
	self:_setZoomLevel(math_min(1, math_max(0, self._currentZoomLevel + deltaZoomLevel)))
end

function CameraController:_setZoomLevel(newZoomLevel)
	self._basePlate:setY(math_lerp(-28.0, -3.77, newZoomLevel))
	self._basePlate:setZ(30)

	self._basePlate.camera:setFOV(math_lerp(8.2, 60, newZoomLevel))

	self._basePlate:setPitch(math_lerp(-.12, -0.02, newZoomLevel))

	self._currentZoomLevel = newZoomLevel
end
