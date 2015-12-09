Floor = class(Floor, Entity, function(self)
	self:_loadModel("objects/Rabbit/Rabbit.obj")
end)

function Floor:_loadModel(modelPath)
	self.model = Engine.getModel(modelPath)
	self.renderer = MeshRenderer()
	self.renderer:setModel(self.model)
	self:addComponent(self.renderer)
	self:setPosition(0,0,0)
end
