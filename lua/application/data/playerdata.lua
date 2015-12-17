
--[[
What goes here:
- Families
- Resources owned by the player
- Properties owned by the player

Later:
- Relations to NPC's

]]--

require "lua/application/data/player/caravandata"
require "lua/application/data/player/familydata"
require "lua/application/data/player/resourcemanager"

PlayerData = class(PlayerData, function(self, serializedData)
	serializedData = serializedData or {}
	self.broadcaster = Broadcaster()

	self.playerCaravan = CaravanData(serializedData.playerCaravan)

	self.resourceManager = ResourceManager(serializedData.resourceManager)
	self._families = {}

	if (serializedData.families) then
		for i=1, #serializedData.families do
			self._families[i] = FamilyData(serializedData.families[i])
		end
	end
end)

function PlayerData:serialize()
	local serializedData = {}

	serializedData.playerCaravan = self.playerCaravan:serialize()

	serializedData.position = self._position

	serializedData.resourceManager = self.resourceManager:serialize()
	serializedData.families = {}

	for i=1,#self._families do
		serializedData.families[i] = self._families[i]:serialize()
	end

	return serializedData
end

function PlayerData:getFamilies()
	return self._families
end
