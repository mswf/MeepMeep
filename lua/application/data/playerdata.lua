
--[[
What goes here:
- Families
- Resources owned by the player
- Properties owned by the player

Later:
- Relations to NPC's

]]--

require "lua/application/data/player/familydata"
require "lua/application/data/player/resourcemanager"

PlayerData = class(PlayerData, function(self, serializedData)
	serializedData = serializedData or {}
	self.broadcaster = Broadcaster()

	self.resourcemanager = ResourceManager(serializedData.resourcemanager)
	self._families = {}

	if (serializedData.families) then
		for i=1, #serializedData.families do
			self._families[i] = FamilyData(serializedData.families[i])
		end
	end
end)

function PlayerData:getFamilies()
	return self._families
end

function PlayerData:serialize()
	local serializedData = {}


	return serializedData
end
