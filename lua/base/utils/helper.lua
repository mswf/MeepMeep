

function table.pack(...)
	return {...}
end

function math.round(num, idp)
	local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

--... is used for color information
function printTableValues(table, prefix, logFunc,...)
	prefix = prefix or ""
	logFunc = logFunc or Log.debug
	logFunc(prefix.."Printing table: "..retrieveVariableName(table),...)
	for k,v in pairs(table) do
		logFunc(prefix..tostring(k).." -> "..tostring(v), ...)
	end
end

--... is used for color information
function printEnumValue(enumValue, prefix, logFunc,...)
	prefix = prefix or ""
	logFunc = logFunc or Log.debug
	logFunc(prefix.."printing enum value:",...)
	logFunc("enum ->	 ".. tostring(enumValue.enum.name),...)
	logFunc("name ->	 ".. tostring(enumValue.name),...)
	logFunc("num ->		".. tostring(enumValue.num),...)
end

--Retrieves the key of this object in the global or given table
function retrieveVariableName(object, t)
  for k,v in pairs(t or _G) do
    if v == object then return k end
  end
  return "NONAME"
end
