Character = class(Character, Entity, function(self)
	self.horizontalSpeed = 0
	self.verticalSpeed = 0
	self.left = false
	self.right = false
	self.up = false
	self.down = false
	self.entity = self
	self:_loadModel("objects/weikie/billboard.obj");

	Log.waka("Character init")
end)

function Character:_loadModel(modelPath)
	--local model = Engine.loadModel("objects/weikie/billboard.obj")
	self.model = Engine.loadModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	self:setPosition(1,1,1)

	--self.entity:addChild(snowman)
end

function Character:moveLeft()
	self.left = true
	Log.waka("left")
end

function Character:moveRight()
	self.right = true
end

function Character:moveUp()
	self.up = true
end

function Character:moveDown()
	self.down = true
end

function Character:update()
	--self:pollInput()
	self:updateVelocity()
	self:roll(1)
	--Log.waka("asd")
end

function Character:updateVelocity()
	horizontalSpeed = self.horizontalSpeed
	verticalSpeed = self.verticalSpeed
	local speed = 1
	local friction = 0.9

	if self.left == true then
		horizontalSpeed = horizontalSpeed - speed
	end
	if (self.right == true) then
		horizontalSpeed = horizontalSpeed + speed
	end
	if self.up == true then
		verticalSpeed = verticalSpeed + speed
	end
	if self.down == true then
		verticalSpeed = verticalSpeed - speed
	end

	--friction
	horizontalSpeed = horizontalSpeed * friction
	verticalSpeed = verticalSpeed * friction

	if horizontalSpeed ~= 0 then
		Log.waka("hor: " .. tostring(horizontalSpeed))
	end
	if verticalSpeed ~= 0 then
		Log.waka("ver: " .. tostring(verticalSpeed))
	end
end
