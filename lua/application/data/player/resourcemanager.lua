
createEnum("ResourceTypes",
	"Food",
	"Water",
	"Wood",
	"Fur",
	"Gold"
)

ResourceManager = class(ResourceManager, function(self, serializedData)
	serializedData = serializedData or {}

	self._resources = {}

	if (serializedData.currentResources) then
		for i=1, #ResourceTypes do
			local type = ResourceTypes[i].name
			self._resources[type] = serializedData.currentResources[type] or 0
		end
	else
		for i=1, #ResourceTypes do
			local type = ResourceTypes[i].name
			self._resources[type] = 0
		end
	end
end)

function ResourceManager:serialize()
	local serializedData = {}

	local resourceTable = {}
	for i=1, #ResourceTypes do
		local type = ResourceTypes[i].name
		resourceTable[type] = self._resources[type]
	end

	serializedData.currentResources = resourceTable

	return serializedData
end

function ResourceManager:changeResource(resourceType, amount)
	local oldAmount = self._resources[resourceType.name]
	local newAmount = self._resources[resourceType.name] + amount
	local delta			= amount
	local increase 	= (amount > 0)

	self._resources[resourceType.name] = newAmount

	GlobalData.playerData.broadcaster:broadcast(resourceType, {
		resourceType = resourceType,
		oldAmount    = oldAmount,
		amount			 = newAmount,
		delta			   = delta,
		increase	   = increase
	})
end

-- #TODO:100 this not here; for now
function ResourceManager:debugFillUIContainer(uiContainer)

	for i=1, #ResourceTypes do
		local type 		= ResourceTypes[i].name
		local amount	= self._resources[type]

		local titleLayout = uiContainer:addHorizontalLayout()

		titleLayout.spacing = 10

		local resourceName = titleLayout:addText()
		resourceName.text = type

		local amountText = titleLayout:addText()
		amountText.text = amount
	end

end
