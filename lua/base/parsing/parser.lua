
Parser = Parser or {}

function Parser.getString(key, parsingContext)
	if (not key) then
		Log.warning("[Parser] tried to parse nil key")
		Log.warning(debug.traceback())
	end

	local stringValue = i18n:get(key)


	return stringValue
end
