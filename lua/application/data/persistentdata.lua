

--[[
What goes here:
- Save Game data
- Settings
- Total Play Time

]]--

PersistentData = class(PersistentData, function(self, serializedData)
	self.broadcaster = Broadcaster()

end)

function PersistentData:serialize()
	local serializedData = {}


	return serializedData
end
