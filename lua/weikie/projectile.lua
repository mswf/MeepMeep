Projectile = class(Projectile, Entity, function(self)
	--self:_loadModel("objects/Rabbit/Rabbit.obj")
	--self:_loadModel("objects/weikie/billboard.obj")
	--self:setMaterial("objects/snowman.png")
	self:_loadModel(ENUM.characterModel)
	self.horizontalSpeed = 0
	self.verticalSpeed = 0
end)

function Projectile:setSpeed(horizontalSpeed, verticalSpeed)
	local modifier = 1.2
	self.horizontalSpeed = horizontalSpeed * modifier
	self.verticalSpeed = verticalSpeed * modifier
end

function Projectile:update(deltaTime)
	self:addX(self.horizontalSpeed * deltaTime)
	self:addZ(self.verticalSpeed * deltaTime)
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
