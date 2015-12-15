

function table.pack(...)
	return {...}
end

function math.round(num, idp)
	local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

--... is used for color information
function printTableValues(printingTable, prefix, logFunc,...)
	prefix = prefix or ""
	logFunc = logFunc or Log.log

	local printData = {}


	table.insert(printData, prefix.."Printing ".. tostring(printingTable))
	local counter = 0

	for k,v in pairs(printingTable) do
		table.insert(printData, prefix..tostring(k).." -> "..tostring(v))
		counter = counter + 1

		if (counter > 20) then
			counter = 0
			logFunc(table.concat(printData, "\n|     "), ...)
			printData = {}
		end
	end
	logFunc(table.concat(printData, "\n|     "), ...)
end


--Retrieves the key of this object in the global or given table
function retrieveVariableName(object, t)
  for k,v in pairs(t or _G) do
    if v == object then return k end
  end
  return "NONAME"
end

if (GAMEDEBUG) then
	function debugTable(table)
		TableDebugUI{table = table}
	end

	function debugEntity(entity)
		EntityDebugUI{entity = entity}
	end

	function debugOutline(entity)
		OutlinerDebugUI{parentEntity = entity}
	end
end
