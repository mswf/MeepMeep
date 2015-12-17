
CaravanData = class(CaravanData, function(self, serializedData)
	serializedData = serializedData or {}
	self._position = serializedData.position
end)


function CaravanData:serialize()
	local serializedData = {}

	serializedData.position = self._position

	return serializedData
end

function CaravanData:getPosition()
	return self._position
end

function CaravanData:setPosition(gridX, gridY, gridZ)
	self._position = {gridX, gridY, gridZ}
end
