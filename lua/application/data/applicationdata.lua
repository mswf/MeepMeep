

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

function ApplicationData:serialize()
	local serializedData = {}

	serializedData.playerData		= self._playerData:serialize()
	serializedData.worldData		= self._worldData:serialize()


	return serializedData
end

function ApplicationData:saveGame(handle)
	local saveData = self:serialize()

	IO.saveTable(handle, saveData)

	-- local saveString = Serialization.dumps(saveData)

	-- TODO: store the saveString using the handle as a key
end

function ApplicationData:loadGame(handle)
	-- TODO: load the saveString using the handle as a key

	-- local saveString = [[{"worldData":{},"playerData":{"resourceManager":{"currentResources":{"Wood":0,"Food":0,"Fur":0,"Gold":0,"Water":0}},"families":{}}}]]
	local saveData = IO.loadTable(handle)

	self:createGameFromSave(saveData)
end

function ApplicationData:createGameFromSave(saveData)
	self._playerData = PlayerData(saveData.playerData)
	self._worldData = WorldData(saveData.worldData)

	self._status = ApplicationData_Status.DataLoaded

	return true
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
