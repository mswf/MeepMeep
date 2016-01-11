
IngameInput = class(IngameInput, function(self, ingamestate, graph)

	self._ingameState = ingamestate
	self._graph = graph


	self._currentSelectedNode	= nil
	self._currentHoveredNode	= nil

	self._currentSelectedUnit	= nil

end)


function IngameInput:update()
	self._graph:registerInput()
	self._graph:draw()


end
