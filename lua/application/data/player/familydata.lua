
FamilyData = class(FamilyData, function(self, serializedData)

	self.position = serializedData.position or "mainCaravan"

	self.experience = serializedData.experience or {}
	self.traits 		= serializedData.traits or {}

	self:_recalculateEffects()
	-- self._effects = nil
end)

function FamilyData:serialize()
	local serializedData = {}


	return serializedData
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


end
