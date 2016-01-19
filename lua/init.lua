
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
Engine.ui.getScreenWidth = Engine.window.getWidth
Engine.ui.getScreenHeight = Engine.window.getHeight
-- Engine.ui.hasFocus bool

Game = Game or {}

if (love) then
	require "lua/love"
end

function Game.crash()
	local noTable
	noTable["yes"] = 500
end

function Game.main()
	-- profiler.start("F")
	GlobalUIManager = UIManager()

	GlobalData = ApplicationData()

	GlobalStateManager = ApplicationStateManager()
	GlobalStateManager:start()
	-- profiler.stop()

end

function Game.update(dt)
	Input.update()

	GlobalStateManager:update(dt)
	GlobalUIManager:update(dt)
end

function Game.onShutdown()
	Log.steb("Shutting down the game")
	return true
end

function Game.onMouseEntered()
	-- Log.steb("Mouse entered")

	Input.isMouseInWindow = true
end

function Game.onMouseLeft()
	Input.isMouseInWindow = false
	-- Log.steb("Mouse left")
end

function Game.onMouseGained()

	-- Log.steb("Mouse gained")
end

function Game.onMouseLost()
	-- Log.steb("Mouse lost")
end


function Game.onWindowResized(newWidth, newHeight)
	-- Log.bobn("resized to "..newWidth.."x"..newHeight)
	Game.windowResizedSignal(newWidth, newHeight)
end

Game.windowResizedSignal = Game.windowResizedSignal or Signal()

function Game.onFocusLost()
	-- Log.steb("Focus lost")
end

function Game.onFocusGained()
	-- Log.steb("Focus gained")

end

function Game.onWindowMinimized()
end

function Game.onWindowMaximized()
end
function Game.onWindowRestored()
end
function Game.onWindowShown()
end
function Game.onWindowHidden()
end

Game.assetManager = Game.assetManager or AssetManager()

function Game.onFileChanged(path)
	Log.warning("[FileChanged] " .. path)
	return Game.assetManager:onFileChanged(path)
end

local contentPath = Engine.system.contentPath
function Game.onDropFile(path)
	Log.warning("[DropFile] " .. path)
	local startPath, endPath = string.find(path, contentPath)
	if (startPath == 1) then
		local relativePath = string.sub(path, endPath+2)
		Log.steb("Dropped file at: " .. relativePath)

		local stringLength = string.len(relativePath)

		local dotPosition  = string.find(relativePath, "%.")

		local type = string.sub(relativePath, dotPosition+1)
		relativePath = string.sub(relativePath, 1, dotPosition-1)

		if (type == "lua") then
			Sandbox.run(loadfile(path))
			-- dofile(path)
			-- require(relativePath)
		end
	end

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
