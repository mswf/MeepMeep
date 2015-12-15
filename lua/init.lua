
GAMEDEBUG = true

if (love) then
	Engine = Engine or {}
	Engine.ui = Engine.ui or {}
	Engine.system = Engine.system or {}
	Engine.system.contentPath = Engine.system.contentPath or ""
end

require "lua/application/logging"
require "lua/base/base"
require "lua/application/data/applicationdata"
require "lua/application/states/applicationstatemanager"


--local Carbon = require("lua/Carbon/init")
--Log.steb("Running Carbon Version " .. Carbon.VersionString)
--Log.steb(Carbon.Support:Report())

--hardcoded tobe engine functions:
Engine.ui.getScreenWidth = function() return 1280 end
Engine.ui.getScreenHeight = function() return 720 end
-- Engine.ui.hasFocus bool

Game = Game or {}

if (love) then
	require "lua/love"
end

function Game.crash()
	noTable["yes"] = 500
end

function Game.main()
	GlobalUIManager = UIManager()

	GlobalData = ApplicationData()

	GlobalStateManager = ApplicationStateManager()
	GlobalStateManager:start()
end

function Game.update(dt)
	-- dt = dt / 1000

	GlobalStateManager:update(dt)
end

function Game.onShutdown()
	Log.steb("Shutting down the game")
	return true
end

function Game.onFocusLose()
end

function Game.onFocusGain()
end

function Game.onResizeWindow(newWidth, newHeight)

end

Debug_FileChangedBroadcaster = Debug_FileChangedBroadcaster or Broadcaster()

function Game.onFileChanged(path)
	local type = nil

	do
		local stringLength = string.len(path)

		dotPosition  = string.find(path, "%.")

		type = string.sub(path, dotPosition+1)
		path = string.sub(path, 1, dotPosition-1)

		-- Windows path fixing step
		path = string.gsub(path, "\\", "/")

		-- Mac returns the full filepath, this step strips away the first part
		-- You're now left with only the reletive path
		local projectStart, projectEnd = string.find(path, "MeepMeep/")
		if (not projectStart) then
			projectStart, projectEnd = string.find(path, "HonkHonk/")
		end

		if (projectStart) then
			path = string.sub(path, projectEnd + 1)
		end
	end

	Log.warning("File Changed: " .. tostring(path) .. ", of type: " .. tostring(type))

	local isSucces = false

	if (type == "lua") then
		if (package.loaded[path]) then
			Log.warning("Reloaded lua file: " .. tostring(path))
			package.loaded[path] = nil
			require(path)

			class:__hotReloadClasses()

			isSucces = true
		else
			-- Log.warning("Package: ".. tostring(path) .. " was not loaded")
			isSucces = false
		end
	else
		isSucces = false
	end

	Debug_FileChangedBroadcaster:broadcast(path, {path = path, type = type})

	return isSucces
end

function Game.game()
	gameTable = {}
	local width,height = 1600/2, 900/2

	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/dungeondescender"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/zombiepop"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/tinglysmagicsolitaire"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/tinglypyramidsolitaire"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/mysticalbirdlink"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/sircoinsalot2"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/duostropicallink"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/andysgolf2"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/atlantris"></iframe>')
	table.insert(gameTable, '<iframe width='..tostring(width)..' height='..tostring(height)..' src="http://games.tinglygames.com/generic/binarybears"></iframe>')
	table.insert(gameTable, '<img src="https://scontent.xx.fbcdn.net/hphotos-xta1/v/t1.0-9/12108733_908901935869876_1953980010345810665_n.jpg?oh=971d742ddab3adfb068c5355b4244abe&oe=56CD2458" />')

	local number = math.random(1, #gameTable)
	Log.steb(gameTable[number])
end
