Floor = class(Floor, Entity, function(self)
	--self:_loadModel("objects/Rabbit/Rabbit.obj")
end)

function Floor:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	--self:setPosition(1,1,-1)
end

function Floor:setMaterial(texturePath)
	local testMat = Material();
	testMat:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(testMat);
end

function Floor:setValue(value)
	self.value = value;

	--should be texture?
	if value == 0 then
		self:_loadModel("objects/Rabbit/Rabbit.obj")
	elseif value == 1 then
		self:_loadModel("objects/Rabbit/Rabbit.obj")
	elseif value == 2 then
		self:_loadModel("objects/Rabbit/Rabbit.obj")
	end

end
