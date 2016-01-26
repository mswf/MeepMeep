
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
-- require "lua/weikie/player"
-- require "lua/weikie/enemy"
-- require "lua/weikie/level"



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

Game.fullScreenMode = 0

local function toggleFullscreen()
	if (Game.fullScreenMode == 0) then
		Engine.window.setPosition(-2000, 100)
		Game.fullScreenMode = 1
	else
		Game.fullScreenMode = 0
		Engine.window.setSize(1280, 720)

		Engine.window.setPosition(50, 50)

	end
	Engine.window.setFullscreenMode(Game.fullScreenMode)
end

function Game.main()
	-- profiler.start("F")
 	toggleFullscreen()

	Engine.importCubeMap(
			"images/Dusk/negx_custom.png",
			"images/Dusk/negy_custom.png",
			"images/Dusk/negz_custom.png",
			"images/Dusk/posx_custom.png",
			"images/Dusk/posy_custom.png",
			"images/Dusk/posz_custom.png",
			"Dusk"
	)
 
	Engine.renderer.setSkybox("Dusk")


	GlobalUIManager = UIManager()
	GlobalData = ApplicationData()
	GlobalStateManager = ApplicationStateManager()
	GlobalStateManager:start()
	-- profiler.stop()

	Engine.importCubeMap(
		"images/Dusk/negx_custom.png",
		"images/Dusk/negy_custom.png",
		"images/Dusk/negz_custom.png",
		"images/Dusk/posx_custom.png",
		"images/Dusk/posy_custom.png",
		"images/Dusk/posz_custom.png",
		"Dusk"
	)
 
	Engine.renderer.setSkybox("Dusk")


	--Engine.importModel("objects/Rabbit/Rabbit.obj")

	--[[
	CAMERA_ENTITY = Entity()
	local camera = Camera()
	CAMERA_ENTITY:addComponent(camera);
	CAMERA_ENTITY:setPosition(9,7,1)
	CAMERA_ENTITY:setRotation(45,0,0)
	camera:setProjectionType(Camera.ProjectionType.PERSPECTIVE)
	camera:makeActive()
	camera:setAspectRatio(1.6)

	LEVEL = Level()

	CAMERA_ENTITY.update = function(self, dt)
		--Game:hackyCameraMovement(dt)
	end
	--]]--
end

function Game:createCamera()

end


function Game.update(dt)
	if (Input.keyDown(KeyCode.F11)) then
		toggleFullscreen()
	end

	Input.update()

	GlobalStateManager:update(dt)

	if Input.keyUp(KeyCode.f) then

		local fileName = "testwk.xml"
		LEVEL:loadLevelFromFile(fileName)
	end
end

function Game.onShutdown()
	return true
end

function Game.onMouseEntered()

	Input.isMouseInWindow = true
end

function Game.onMouseLeft()
	Input.isMouseInWindow = false
end

function Game.onMouseGained()

end

function Game.onMouseLost()
end


function Game.onWindowResized(newWidth, newHeight)
	Game.windowResizedSignal(newWidth, newHeight)
end

Game.windowResizedSignal = Game.windowResizedSignal or Signal()

function Game.onFocusLost()
end

function Game.onFocusGained()

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
	-- Log.warning("[FileChanged] " .. path)
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

function Game:hackyCameraMovement(dt)
	local speed = 5 * dt
	local rotateSpeed = 40 * dt

	-- speed = 0
	-- rotateSpeed = 0

	if Input.key(KeyCode.w) == true then
		CAMERA_ENTITY:addZ(speed)
	end

	if Input.key(KeyCode.d) == true then
		CAMERA_ENTITY:addX(-speed)
	end

	if Input.key(KeyCode.s) == true then
		CAMERA_ENTITY:addZ(-speed)
	end

	if Input.key(KeyCode.a) == true then
		CAMERA_ENTITY:addX(speed)
	end

	if Input.key(KeyCode.q) == true then
		CAMERA_ENTITY:yaw(rotateSpeed)
	end

	if Input.key(KeyCode.e) == true then
		CAMERA_ENTITY:yaw(-rotateSpeed)
	end

	if Input.key(KeyCode.z) == true then
		CAMERA_ENTITY:addY(-speed)
	end

	if Input.key(KeyCode.x) == true then
		CAMERA_ENTITY:addY(speed)
	end

	if Input.keyDown(KeyCode.k) == true then
		--Log.waka("asd")
		CAMERA_ENTITY:setPosition(9,7,1)
		CAMERA_ENTITY:setRotation(45,0,0)
	end
end
