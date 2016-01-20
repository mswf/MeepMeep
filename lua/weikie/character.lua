Character = class(Character, Entity, function(self)
	self.horizontalSpeed = 0
	self.verticalSpeed = 0
	self.left = false
	self.right = false
	self.up = false
	self.down = false
end)

function Character:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	self:setPosition(0,0,0)
end

function Character:setMaterial(texturePath)
	Log.waka("texture path:" .. texturePath)
	local material = Material();
	material:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(material);
end

function Character:moveLeft()
	self.left = true
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

function Character:update(deltaTime)
	self:updateVelocity(deltaTime)
	self.up = false
	self.down = false
	self.left = false
	self.right = false
end

function Character:updateVelocity(deltaTime)
	local horizontalSpeed = self.horizontalSpeed
	local verticalSpeed = self.verticalSpeed

	local speed = 1
	local friction = 0.8

	if self.left == true then
		horizontalSpeed = horizontalSpeed - speed
	end
	if self.right == true then
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

	self:addX(horizontalSpeed * deltaTime)
	self:addZ(verticalSpeed * deltaTime)

	self.horizontalSpeed = horizontalSpeed
	self.verticalSpeed = verticalSpeed
end
