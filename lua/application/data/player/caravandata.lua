
CaravanData = class(CaravanData, function(self, serializedData)
	serializedData = serializedData or {}
	self._position = serializedData.position or {5,5,1}
end)


function CaravanData:serialize()
	local serializedData = {}

	serializedData.position = self._position

	return serializedData
end

function CaravanData:getPosition()
	return self._position[1], self._position[2], self._position[3]
end

function CaravanData:setPosition(gridX, gridY, gridZ)
	self._position = {gridX, gridY, gridZ}
end
