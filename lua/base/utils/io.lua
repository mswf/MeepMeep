
local Carbon_IO = require("lua/Carbon/init").IO
local Serialization = require "lua/base/libs/smallfolk"


IO = IO or {}

local basePath = Engine.system.contentPath .. "/"

function IO.saveTable(fileName, saveTable)
	local saveString = Serialization.dumps(saveTable)

	IO.saveToFile(fileName, saveString)
end

function IO.loadTable(fileName)
	local saveString = IO.loadFromFile(fileName)
	if (saveString) then
		return Serialization.loads(saveString)
	else
		Log.error("Didn't get a proper string back")
	end
end

function IO.saveToFile(fileName, saveString)
	local path = basePath

	local file, error = Carbon_IO.Open(path .. fileName .. ".txt", "wb")
	if (not error) then
		local writeResult, writeError = file:Write(saveString)
		if (not writeError) then
			local closeResult = file:Close()
			if (not closeResult) then
				Log.error("error while closing file")
			end
		else
			Log.error(writeError)
		end
	else
		Log.error(error)
	end
end


function IO.loadFromFile(fileName)
	local path = basePath

	local file, error = Carbon_IO.Open(path .. fileName .. ".txt", "r")
	if (not error) then
		local loadResult, writeError = file:Read()
		if (not writeError) then
			local closeResult = file:Close()
			if (not closeResult) then
				Log.error("error while closing file")
			else
				Log.warning("succesfully loaded string:")
				Log.warning(loadResult)
				return loadResult
			end
		else
			Log.error(writeError)
		end
	else
		Log.error(error)
	end

end
