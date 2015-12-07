
EntityDebugUI = class(EntityDebugUI, UIBase)


function EntityDebugUI:_createUI()
	self.currentEntity = self._params.entity

	local entity = self._params.entity
	local window = self.window

	local titleText = window:addText()
	titleText.text = tostring(entity)

	-- transform debug
	do
		local DEVIATION = 10

		local transformTree = window:addTree("Transform")
		transformTree.opened = true

		local positionTree = transformTree:addTree("Position")
		local xPos = positionTree:addSlider("x")
		xPos.format = "%.3f"
		xPos.value = entity:getX()
		xPos.minValue = entity:getX() - DEVIATION
		xPos.maxValue = entity:getX() + DEVIATION
		xPos.onChange = function(slider) entity:setX(slider.value) end
		self.xPos = xPos

		local yPos = positionTree:addSlider("y")
		yPos.format = "%.3f"
		yPos.value = entity:getY()
		yPos.minValue = entity:getY() - DEVIATION
		yPos.maxValue = entity:getY() + DEVIATION
		yPos.onChange = function(slider) entity:setY(slider.value) end
		self.yPos = yPos

		local zPos = positionTree:addSlider("z")
		zPos.value = entity:getZ()

		zPos.format = "%.3f"
		zPos.minValue = entity:getZ() - DEVIATION
		zPos.maxValue = entity:getZ() + DEVIATION
		zPos.onChange = function(slider) entity:setZ(slider.value) end
		self.zPos = zPos

		--- ROTATION
		local ROT_MIN = 0
		local ROT_MAX = 1
		local rotationTree = transformTree:addTree("Rotation")
		local xRot = rotationTree:addSlider("pitch")
		xRot.format = "%.3f"
		xRot.value = entity:getPitch()
		xRot.minValue = ROT_MIN
		xRot.maxValue = ROT_MAX
		xRot.onChange = function(slider)
			entity:setPitch(slider.value)
			-- slider.value = entity:getPitch()
		end
		self.xRot = xRot

		local yRot = rotationTree:addSlider("yaw")
		yRot.format = "%.3f"
		yRot.value = entity:getYaw()
		yRot.minValue = ROT_MIN
		yRot.maxValue = ROT_MAX
		yRot.onChange = function(slider)
			entity:setYaw(slider.value)
			-- slider.value = entity:getRoll()
		end
		self.yRot = yRot

		local zRot = rotationTree:addSlider("roll")
		zRot.value = entity:getRoll()
		zRot.format = "%.3f"
		zRot.minValue = ROT_MIN
		zRot.maxValue = ROT_MAX
		zRot.onChange = function(slider)
			entity:setRoll(slider.value)
			-- slider.value = entity:getYaw()
		end
		self.zRot = zRot

		--- SCALE
		local SCALE_MIN = 0
		local SCALE_MAX = 2

		local scaleTree = transformTree:addTree("Scale")
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
