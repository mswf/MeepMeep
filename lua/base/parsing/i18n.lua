

i18n = {
	TESTKEY 										= "Hello",
	TESTKEY_NUMBER							= "",
}

function i18n:get(key)
	local stringValue = self[key]
	if (not stringValue) then
		local width = 200 + string.len( tostring(key))*12
		Log.warning("[i18n] <marquee behavior='alternate' width='".. width .."'>Can't find ".. tostring(key) .."</marquee>")
		stringValue = "__missing__"
	end

	return stringValue
end
