

local names = {
	"Fallback Name 1",
	"Fallback Name 2",
	"Fallback Name 3"
}
local function getRandomGender()
	if (math.random() > .95) then
-- if (math.random() > 1) then -- LOL LUA JOKE HAR HAR
		return "nonbinary"
	elseif (math.random() > .5) then
		return "male"
	else
		return "female"
	end
end

FamilyMemberData = class(FamilyMemberData, function(self, serializedData)
	self.age = serializedData.age or 21

	self.gender = serializedData.gender or getRandomGender()
	self.name = serializedData.name or "NO NAME"

end)

function FamilyMemberData:serialize()
	local serializedData = {}

	return serializedData
end
