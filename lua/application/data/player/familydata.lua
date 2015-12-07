
require "lua/application/data/player/familymemberdata"

FamilyData = class(FamilyData, function(self, serializedData)
	serializedData = serializedData or {}

	self.position = serializedData.position or "mainCaravan"

	self.experience = serializedData.experience or {}

	-- motivation
	-- heritage
	self.traits 		= serializedData.traits or {}

	self.members = {}

	for i=1, #serializedData.members do
		self.members[i] = FamilyMemberData(serializedData.member[i])
	end

	self:_recalculateEffects()
	-- self._effects = nil
end)

function FamilyData:serialize()
	local serializedData = {}

	serializedData.position = self.position

	serializedData.experience = self.experience
	serializedData.traits = self.traits

	serializedData.members = {}

	for i=1, #self.members do
		serializedData.members[i] = self.members[i]:serialize()
	end

	return serializedData
end

function FamilyData:processEvent(params)
	--[[
		process something that happened
		- completed a tasks (gain xp)
		- time passes (change satisfaction)
		- etc (smth smth, you get family member)
	]]

end

function FamilyData:addMember(params)
	table.insert(self.members, FamilyMemberData(params))
end

function FamilyData:removeMember(member)
	local members = self.members
	for i=1, #members do
		if (members[i] == member) then
			table.remove(members, i)
			break
		end
	end
end

-- TODO: this not here; for now
function FamilyData:debugFillUIContainer(uiContainer)

end

function FamilyData:getTooltip()
	local tooltipText = ""

	return tooltipText
end

function FamilyData:getEffects()

end

function FamilyData:changeExperience(type, delta)
	if (not self.experience[type]) then
		self.experience[type] = 0
	end

	self.experience[type] = self.experience[type] + delta

	self._recalculateEffects()
end

function FamilyData:_recalculateEffects()
	--[[
	Determine effectiveness at tasks using:
	- experience
	- number and age of members

	]]--


end
