Projectile = class(Projectile, Entity, function(self)
	--self:_loadModel("objects/Rabbit/Rabbit.obj")
	--self:_loadModel("objects/weikie/billboard.obj")
	--self:setMaterial("objects/snowman.png")
	self:_loadModel(ENUM.characterModel)
	self.horizontalSpeed = 0
	self.verticalSpeed = 0
	self.timer = 0
	local scale = 0.4
	self:setScale(scale, scale, scale)
end)

function Projectile:setSpeed(horizontalSpeed, verticalSpeed)
	horizontalSpeed, verticalSpeed = math.normalize(horizontalSpeed, verticalSpeed)

	local modifier = 10

	self.horizontalSpeed = horizontalSpeed * modifier
	self.verticalSpeed = verticalSpeed * modifier

	self:update(0.3 / modifier)
end

function Projectile:update(deltaTime)
	self:addX(self.horizontalSpeed * deltaTime)
	self:addZ(self.verticalSpeed * deltaTime)
	self.timer = self.timer + deltaTime

	if self.timer > 5 then
		self:destroy()
	end
end

function Projectile:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	self:yaw(180)
end

function Projectile:setMaterial(texturePath)
	local material = Material();
	material:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(material);
end
