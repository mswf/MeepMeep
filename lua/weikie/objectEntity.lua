ObjectEntity = class(ObjectEntity, Entity, function(self)

end)

function ObjectEntity:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
end

function ObjectEntity:setMaterial(texturePath)
	Log.waka("texture path:" .. texturePath)
	local material = Material();
	material:setDiffuseTexture(texturePath);
	self.meshRenderer:setMaterial(material);
end
