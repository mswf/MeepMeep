
math.randomseed(os.time())

function script_path()
    return debug.getinfo(2, "S").source:sub(2):sub(0,-10):gsub("\\", "/")
end
ABS_PATH = script_path()


require "lua/base/base"
require "lua/application/logging"

--local Carbon = require("lua/Carbon/init")

--Log.steb("Running Carbon Version " .. Carbon.VersionString)
--Log.steb(Carbon.Support:Report())

Game = Game or {}

if (love) then
	require "lua/love"
end

function Game.main()

	--Log.steb("Game.main called")

	for i=1,1 do
		Log.steb()
		Log.bobn()
		Log.tinas()
		Log.waka()
		Log.gwebl()
	end

	--Game.game()

end

function Game.update(dt)
	--Log.steb("update the game at dt: " .. tostring(dt))

end



function Game.onShutdown()
	Log.steb("Shutting down the game")
end



function Game.onFocusLost()
end

function Game.onFocusGained()
end


function Game.testMesh()
	local Vector3 = Carbon.Math.Vector3
	local mesh = MeshBuilder()

	mesh:addVertex(Vector3(-1, 0,-1))
	mesh:addVertex(Vector3(-1, 0, 1))
	mesh:addVertex(Vector3( 1, 0,-1))
	mesh:addVertex(Vector3( 1, 0, 1))

	for i=1, 4 do
		mesh:addNormal(Vector3( 0, 1, 0))
	end

	mesh:addTriangle(1,2,3)
	mesh:addTriangle(2,4,3)

	mesh:saveToFile("plane")
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

-- Game.testMesh()
--When logging 'nil' there's a fallback string that gets printed
-- Log.steb()
-- Log.bobn()
-- Log.tinas()
-- Log.gwebl()
-- Log.waka()
--
-- Log.steb("-")
--
-- createEnum("TestEnum", "One", "Two", "Three")
-- Log.steb(TestEnum)
--
-- Log.steb("-")
-- local test = TestEnum.One
-- Log.steb(test)
--
--
-- local tween = Tween()
--

-- local Vector3 = require "lua/base/math/vector3"
-- Log.steb("Got the library")
--
-- local v1 = Vector3(3,3,3)
--
-- Log.steb(v1)

--[[
local cooks = require "lua/application/credits"
print("CREDITS:")
for i=1, #cooks do
	print("")
	print(cooks[i][1])
	print(string.upper(cooks[i][2]))
end
]]--
