
EntityDebugUI = class(EntityDebugUI, UIBase)


function EntityDebugUI:_createUI()
	self.currentEntity = self._params.entity

	local anchorToBottom = self._params.anchorToBottom

	local entity = self._params.entity
	local window = self.window

	-- window.movable = false

	if (self._params.windowTitle) then
		window.title = "Inspector: " .. tostring(self._params.windowTitle)
	else
		window.title = "Inspector: " .. tostring(entity)
	end

	window.height = 300
	window.width = 280

	window.x = Engine.window.getWidth() - window.width

	if (anchorToBottom) then
		window.y = Engine.window.getHeight() - window.height
	end

	window.onResize = function(self)
		self.width = 280
		local screenHeight = Engine.window.getHeight()
		if (self.height> screenHeight) then
			self.height = screenHeight
		end
	end

	window.onMove = function(self)
		local y = self.y
		local screenHeight = Engine.window.getHeight()
		if (y < 0) then
			self.y = 0
		elseif (y > screenHeight - self.height ) then
			self.y = screenHeight- self.height
		end
		self.x = Engine.window.getWidth() - self.width
	end


	local titleText = window:addText()
	titleText.text = tostring(entity)

	-- transform debug
	do
		local DEVIATION = 10

		local transformTree = window:addTree("Transform")
		transformTree.opened = true

		local positionTree = transformTree:addTree("Position")
		local xPos = positionTree:addDrag("x")
		xPos.format = "%.3f"
		xPos.speed = 0.1
		xPos.value = entity:getX()
		xPos.minValue = entity:getX() + DEVIATION
		xPos.maxValue = entity:getX() - DEVIATION
		xPos.onChange = function(slider) entity:setX(slider.value) end
		self.xPos = xPos

		local yPos = positionTree:addDrag("y")
		yPos.format = "%.3f"
		yPos.speed = 0.1
		yPos.value = entity:getY()
		yPos.minValue = entity:getY() + DEVIATION
		yPos.maxValue = entity:getY() - DEVIATION
		yPos.onChange = function(slider) entity:setY(slider.value) end
		self.yPos = yPos

		local zPos = positionTree:addDrag("z")
		zPos.format = "%.3f"
		zPos.speed = 0.1
		zPos.value = entity:getZ()
		zPos.minValue = entity:getZ() + DEVIATION
		zPos.maxValue = entity:getZ() - DEVIATION
		zPos.onChange = function(slider) entity:setZ(slider.value) end
		self.zPos = zPos

		--- ROTATION
		local ROT_MIN = 0
		local ROT_MAX = 1
		local rotationTree = transformTree:addTree("Rotation")
		local xRot = rotationTree:addDrag("pitch")
		xRot.format = "%.3f"
		xRot.speed = 0.004
		xRot.value = entity:getPitch()
		xRot.minValue = ROT_MAX
		xRot.maxValue = ROT_MIN
		xRot.onChange = function(slider)
			entity:setPitch(slider.value)
			-- slider.value = entity:getPitch()
		end
		self.xRot = xRot

		local yRot = rotationTree:addDrag("yaw")
		yRot.format = "%.3f"
		yRot.speed = 0.004
		yRot.value = entity:getYaw()
		yRot.minValue = ROT_MAX
		yRot.maxValue = ROT_MIN
		yRot.onChange = function(slider)
			entity:setYaw(slider.value)
			-- slider.value = entity:getRoll()
		end
		self.yRot = yRot

		local zRot = rotationTree:addDrag("roll")
		zRot.format = "%.3f"
		zRot.speed = 0.004
		zRot.value = entity:getRoll()
		zRot.minValue = ROT_MAX
		zRot.maxValue = ROT_MIN
		zRot.onChange = function(slider)
			entity:setRoll(slider.value)
			-- slider.value = entity:getYaw()
		end
		self.zRot = zRot

		--- SCALE
		local SCALE_MIN = 0
		local SCALE_MAX = 2

		local scaleTree = transformTree:addTree("Scale")
		scaleTree.opened = false

		local xScale = scaleTree:addSlider("sX")
		xScale.format = "%.3f"
		xScale.value = entity:getScaleX()
		xScale.minValue = SCALE_MIN
		xScale.maxValue = SCALE_MAX
		xScale.onChange = function(slider)
			entity:setScaleX(slider.value)
			-- slider.value = entity:getPitch()
		end
		self.xScale = xScale

		local yScale = scaleTree:addSlider("sY")
		yScale.format = "%.3f"
		yScale.value = entity:getScaleY()
		yScale.minValue = SCALE_MIN
		yScale.maxValue = SCALE_MAX
		yScale.onChange = function(slider)
			entity:setScaleY(slider.value)
			-- slider.value = entity:getRoll()
		end
		self.yScale = yScale

		local zScale = scaleTree:addSlider("sZ")
		zScale.value = entity:getScaleZ()
		zScale.format = "%.3f"
		zScale.minValue = SCALE_MIN
		zScale.maxValue = SCALE_MAX
		zScale.onChange = function(slider)
			entity:setScaleZ(slider.value)
			-- slider.value = entity:getYaw()
		end
		self.zScale = zScale

		-- local children = entity:getChildren()
		-- local scaleTree = transformTree:addTree("Scale")
		-- scaleTree.opened = false
	end

	if (entity.debugRenderer) then
		local debugTree = window:addTree("Debug Renderer")
		local debugText = debugTree:addText("Entity has a debug renderer!")
	end

	if (entity.meshRenderer) then
		local rendererTree = window:addTree("Renderer")
		local rendererText = rendererTree:addText("Entity has a renderer component.")
	end

	if (entity.camera) then
		local cameraTree = window:addTree("Camera")
		local cameraText = cameraTree:addText("Entity has a camera component.")
	end

	if (entity.node) then
		local nodeTree = window:addTree("Node Component")

		local unitsTree = nodeTree:addTree("Units:")
		unitsTree.collapsed = false

		local units = entity.node._units
		local unitsCount = #units

		for i=1, unitsCount do
			unitsTree:addText("- " .. units[i].tooltipText)
		end
	end

	-- entity.debugRenderer
end

function EntityDebugUI:update(dt)
	if (self.currentEntity) then
		local entity = self.currentEntity

		self.xPos.value = entity:getX()
		self.yPos.value = entity:getY()
		self.zPos.value = entity:getZ()

		self.xRot.value	 = entity:getPitch()
		self.yRot.value	 = entity:getYaw()
		self.zRot.value	 = entity:getRoll()

		self.xScale.value	 = entity:getScaleX()
		self.yScale.value	 = entity:getScaleY()
		self.zScale.value	 = entity:getScaleZ()

	end
end

function EntityDebugUI:onWindowResized()
	self.window:onMove()
end
