ObjectEntity = class(ObjectEntity, Entity, function(self)

end)

function ObjectEntity:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self:addComponent(self.renderer)
	self.renderer:setModel(self.model)
end

function ObjectEntity:setMaterial(texturePath)
	local material = Material();
	material:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(material);
end
