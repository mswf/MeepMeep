

i18n = {
	TESTKEY 										= "Hello",
	TESTKEY_NUMBER							= "",
}

function i18n:get(key)
	local stringValue = self[key]
	if (not stringValue) then
		Log.warning("[i18n] <marquee behavior='alternate' width='150'>Can't find ".. tostring(key) .."</marquee>")
		stringValue = "__missing__"
	end

	return stringValue
end
