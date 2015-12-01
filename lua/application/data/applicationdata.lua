
require "lua/application/data/playerdata"
require "lua/application/data/worlddata"
require "lua/application/data/persistentdata"

ApplicationData = class(ApplicationData, function(self)
	-- always has to be loaded
	self.persistentData = PersistentData()

	self._playerData = nil
	self._worldData = nil

	self._status = self.Status.NoDataLoaded
end)

createPrivateEnum(ApplicationData, "Status",
"NoDataLoaded",
"DataLoaded")

local ApplicationData_Status = ApplicationData.Status

function ApplicationData:getPlayerData ()
	if (self._status == ApplicationData_Status.DataLoaded) then
		return self._playerData
	else
		return nil
	end
end

function ApplicationData:getWorldData ()
	if (self._status == ApplicationData_Status.DataLoaded) then
		return self._worldData
	else
		return nil
	end
end

function ApplicationData:createGameNew()

	self._playerData = PlayerData()
	self._worldData = WorldData()

	self._status = ApplicationData_Status.DataLoaded

	return true
end

function ApplicationData:createGameFromSave(saveData)
	self._status = ApplicationData_Status.DataLoaded

	return self:createGameNew()

	-- TODO: actual load from serialzed stuff here
	-- if (somethingGoesWrong) then
	--	self._status = ApplicationData_Status.DataLoaded
	-- 	return false
	-- else
	--	self._status = ApplicationData_Status.NoDataLoaded
	-- 	return true
	-- end
end

function ApplicationData:saveData()
	if (self._status == ApplicationData_Status.NoDataLoaded) then
		-- TODO: serialize everything
		--

		return true
	else
		Log.error("[ApplicationData] tried to save the game without there being data")
		return false
	end

end
