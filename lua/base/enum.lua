
local enumMetaTable = {
	__newindex = function(table, index, value)
		Log.error("[enum] something tried to change the enum.")
		return nil
	end,
	__tostring = function(value)
		return "[ENUM] " .. retrieveVariableName(value)
	end,
	__concat = function(lhs, rhs)
		return tostring(lhs) .. tostring(rhs)
	end
}

local enumValueMetatable = {
	__tostring = function(value)
		return "[ENUMVALUE] " .. retrieveVariableName(value.enum) .. "." .. value.name
	end,
	__concat = function(lhs, rhs)
		return tostring(lhs) .. tostring(rhs)
	end
}

function setEnum(table, enumName, ...)
	local enumeration = table[enumName]
	if (not enumeration) then
		enumeration = setmetatable({}, enumMetaTable)
	end

	for index, value in ipairs({...}) do
		local enumValue = setmetatable({num = index, name = value, enum = enumeration}, enumValueMetatable)
		rawset(enumeration, index, enumValue)
		rawset(enumeration, value, enumValue)
	end

	rawset(table, enumName, enumeration)

	return enumeration
end

function createEnum(enumName, ...)
	return setEnum(_G, enumName, ...)
end

function createPrivateEnum(table, enumName, ...)
	return setEnum(table, enumName, ...)
end

function isEnum(table)
	return getmetatable(table) == enumMetatable
end

function isEnumValue(value)
  return getmetatable(value) == enumValueMetatable
end

function isEnumMember(enumValue, enum)
	return arrayContains(enum, value)
end

function enumify(customEnum, enumName)
	for index, enumValue in ipairs(customEnum) do
		customEnum[enumValue.name] = enumValue
		enumValue.enum = customEnum
		enumValue.num = index
		setmetatable(enumValue, enumValueMetatable)
	end
	if (enumName ~= nil) then
		customEnum.name = enumName
	else
		Log.error("[enum] tried to enumify a table without providing an enumName")
	end

	setmetatable(customEnum, enumMetatable)
end
