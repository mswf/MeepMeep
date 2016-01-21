Floor = class(Floor, Entity, function(self)
	self:_loadModel("content/models/tiles/cave_floor.obj")
	self:setValue(1)
end)

function Floor:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	--self:setPosition(1,1,-1)
end

function Floor:setMaterial(texturePath)
	local material = Material();
	material:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(material);
end

function Floor:setValue(value)
	self.value = value;
	self:setMaterial(ENUM.FLOOR_TILES[value])
end
