

FamilyMemberData = class(FamilyMemberData, function(self, serializedData)
	self.age = serializedData.age or 21

	self.gender = serializedData.gender or "male"
end)

function FamilyMemberData:serialize()
	local serializedData = {}

	return serializedData
end
