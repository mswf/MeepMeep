
Log = Log or {}

Log.detailLevel = Log.detailLevel or {}

local Users = {
	"Steff",
	"Robin",
	"Valentinas",
	"Gerben",
	"Weikie",
	"Warning",
	"Error"
}


local logFunc
local logFuncColor

if (love) then
	logFunc = print
	logFuncColor = function(text, ...) print(text) end
else
	logFunc = Engine.log
	logFuncColor = function(text, ...) Engine.log(text, ...) end
end


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
		if (type(text) == "table") then
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
		if (type(text) == "table") then
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
		if (type(text) == "table") then
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
		if (type(text) == "table") then
			Log.printTable(Users.Weikie, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Weikie, "[Weikie]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Weikie, "[Weikie]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Weikie, "[Weikie]: " .. "nil", detail, subject, BG, FG)
	end
end

function Log.gwebl(text, detail, subject)
	local BG, FG = "rgba(73,15,1,0.8)", "#ffffff"

	if (text ~= nil) then
		if (type(text) == "table") then
			Log.printTable(Users.Gerben, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(Users.Gerben, "[Gerben]: ".. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(Users.Gerben, "[Gerben]: "..tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(Users.Gerben, "[Gerben]: " .. "\n   (   )\n (   ) (\n  ) _   )\n   ( \\_\n _(_\\ \\)__\n(____\\___))", detail, subject, BG, FG)
	end
end

function Log.warning(text, detail, subject)
--	local BG, FG = "#663399", "#FF22AA"
	local BG, FG = "rgba(255, 153, 0,0.8)", "#FFFFFF"
	local USER = Users.Warning
	local USERSTRING = "[Warning]: "

	if (text ~= nil) then
		if (type(text) == "table") then
			Log.printTable(USER, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(USER, USERSTRING .. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(USER, USERSTRING .. tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(USER, USERSTRING .. "nil", detail, subject, BG, FG)
	end
end

function Log.error(text, detail, subject)
--	local BG, FG = "#663399", "#FF22AA"
	local BG, FG = "rgba(255, 8, 0, 0.8)", "#FFFFFF"
	local USER = Users.Error
	local USERSTRING = "[Error]: "

	if (text ~= nil) then
		if (type(text) == "table") then
			Log.printTable(USER, text, detail, subject, BG, FG)
		else
			if (text == "-") then
				Log.log(USER, USERSTRING .. "-------------------------------------------------", detail, subject, BG, FG)
			else
				Log.log(USER, USERSTRING .. tostring(text), detail, subject, BG, FG)
			end
		end
	else
		Log.log(USER, USERSTRING .. "nil", detail, subject, BG, FG)
	end
end
