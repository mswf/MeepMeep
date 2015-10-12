
Log = Log or {}

Log.detailLevel = Log.detailLevel or {}

local Users = {
	"Steff",
	"Robin",
	"Valentinas",
	"Gerben",
	"Weikie"
}

local logFunc = Engine.Log
local logFuncColor = function(text, ...) Engine.Log(text, ...) end

function Log.log(user, text, detailLevel, subject, ...)
	if (Log.isEnabled(user,detailLevel,subject)) then
		local subjectString = Log.getPrefix(subject, detailLevel)

		if (...) then logFunc = logFuncColor end --if color information is given, use it
		logFunc(subjectString .. tostring(text),...)
	end
end

function Log.printTable(user, table, detailLevel, subject, ...)
	if (Log.isEnabled(user,detailLevel,subject)) then
		local subjectString = Log.getPrefix(subject, detailLevel)

		if (...) then logFunc = logFuncColor end --if color information is given, use it
		printTableValues(table, subjectString, logFunc, ...)
	end
end

function Log.printEnum(user, enum, detailLevel, subject, ...)
	if (Log.isEnabled(user,detailLevel,subject)) then
		local subjectString = Log.getPrefix(subject, detailLevel)

		if (...) then logFunc = logFuncColor end --if color information is given, use it
		printEnumValue(enum, subjectString, logFunc, ...)
	end
end

--Standardized subject string
function Log.getPrefix(subject, detailLevel)
	local subjectString = ""
	if subject ~= nil then
		subjectString = string.rep("	",detailLevel or 0) .. string.format("[%s] ",tostring(subject))
	end
	return subjectString
end

--Outputs whether the settings allow the logging to actually happen
function Log.isEnabled(user, detailLevel, subject)
	detailLevel = detailLevel or 0
	local enabled = subject == nil or Log.detailLevel[subject] == nil or Log.detailLevel[subject] >= detailLevel
	return enabled, subjectString
end


function Log.steb(text, detail, subject)
--	local BG, FG = "#663399", "#FF22AA"
	local BG, FG = "rgba(102,51,153,0.8)", "#FF22AA"

	if (text ~= nil) then
		if (isEnumValue(text)) then
			Log.printEnum(Users.Steff, text, detail, subject, BG, FG)
		elseif (type(text) == "table") then
			Log.printTable(Users.Steff, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Steff, "[Steff]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Steff, "[Steff]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Steff, "[Steff]: " .. "hai", detail, subject, BG, FG)
	end
end



function Log.bobn(text, detail, subject)
	local BG, FG = "rgba(1,176,250,0.8)", "#ffffff"

	if (text ~= nil) then
		if (isEnumValue(text)) then
			Log.printEnum(Users.Robin, text, detail, subject, BG, FG)
		elseif (type(text) == "table") then
			Log.printTable(Users.Robin, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Robin, "[Robin]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Robin, "[Robin]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Robin, "[Robin]: " .. "pls", detail, subject, BG, FG)
	end
end



function Log.tinas(text, detail, subject)
	local BG, FG = "rgba(24,97,51,0.8)", "#ffffff"

	if (text ~= nil) then
		if (isEnumValue(text)) then
			Log.printEnum(Users.Valentinas, text, detail, subject, BG, FG)
		elseif (type(text) == "table") then
			Log.printTable(Users.Valentinas, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Valentinas, "[Valentinas]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Valentinas, "[Valentinas]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Valentinas, "[Valentinas]: " .. "bah humbug", detail, subject, BG, FG)
	end
end

function Log.waka(text, detail, subject)
	local BG, FG = "rgba(254,245,2,0.8)", "#31311b"

	if (text ~= nil) then
		if (isEnumValue(text)) then
			Log.printEnum(Users.Weikie, text, detail, subject, BG, FG)
		elseif (type(text) == "table") then
			Log.printTable(Users.Weikie, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Weikie, "[Weikie]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Weikie, "[Weikie]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Weikie, "[Weikie]: " .. "chocobo", detail, subject, BG, FG)
	end
end

function Log.gwebl(text, detail, subject)
	local BG, FG = "rgba(73,15,1,0.8)", "#ffffff"
	
	if (text ~= nil) then
		if (isEnumValue(text)) then
			Log.printEnum(Users.Gerben, text, detail, subject, BG, FG)
		elseif (type(text) == "table") then
			Log.printTable(Users.Gerben, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Gerben, "[Gerben]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Gerben, "[Gerben]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Gerben, "[Gerben]: " .. "king pleb", detail, subject, BG, FG)
	end
end
