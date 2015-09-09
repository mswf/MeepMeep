--If this file is hot reloaded, the enumValueMetatable is replaced, so some functions might work differently

local enumValueMetatable =
{
  __lt = function (lhs, rhs)
    return lhs.num < rhs.num
  end,
  __le = function (lhs, rhs) -- not really necessary, just improves "<=" and ">" performance
    return lhs.num <= rhs.num
  end,
  __tostring = function (value)
    return value.name
  end,
  __concat = function (lhs,rhs)
    return tostring(lhs)..tostring(rhs)
  end
}

local enumMetatable = {
  __newindex = function(table,numValue,nameValue)
    return error("Enums are read-only tables. Add any values in the constructor.")
  end
}
function enum(...)
  local enumeration = setmetatable({},enumMetatable)

  for numValue,nameValue in ipairs(...) do
    local value = setmetatable({num = numValue, name = nameValue},enumValueMetatable)
    rawset(enumeration,nameValue,value)
    rawset(enumeration,numValue,value)
  end
  return enumeration
end

function setEnum(t,enumerationName,enumeration, ...)
  local enumeration = t[enumerationName]
  if (not enumeration) then
    local mt = {
      __newindex = function(table,numValue,nameValue)
        return error("Enums are read-only tables. Add any values in the constructor.")
      end
    }
    enumeration = setmetatable({name = enumerationName},mt)
  end
  for numValue,nameValue in ipairs(table.pack(...)) do
    if (not enumeration[numValue]) then
      local value = setmetatable({num = numValue, name = nameValue, enum = enumeration},enumValueMetatable)
      rawset(enumeration,nameValue,value)
      rawset(enumeration,numValue,value)
    end
  end
  rawset(t,enumerationName,enumeration)

  return enumeration
end

function isEnumMember(value, enum)
  return arrayContains(enum, value)
end

function createEnum(enumerationName, ...)
  return setEnum(_G,enumerationName,enumeration, ...)
end

function createPrivateEnum(t,enumerationName, ...)
  return setEnum(t,enumerationName,enumeration, ...)
end

function isEnumValue(value)
  return getmetatable(value) == enumValueMetatable
end

--used to create custom enum-likes
function enumify(customEnum, enumName)
  --enforce double indexing enums
  local toInsert = {}
  for i,enumValue in ipairs(customEnum) do
    customEnum[enumValue.name] = enumValue
    enumValue.enum = customEnum
    enumValue.num = i
    setmetatable(enumValue, enumValueMetatable)
  end
  if (enumName ~= nil) then
  	customEnum.name = enumName
  end

  setmetatable(customEnum, enumMetatable)
end
