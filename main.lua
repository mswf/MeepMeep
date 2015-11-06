
math.randomseed(os.time())

function script_path()
    return debug.getinfo(2, "S").source:sub(2):sub(0,-10):gsub("\\", "/")
end
ABS_PATH = script_path()


require "lua/application/logging"

require "lua/base/base"

--local Carbon = require("lua/Carbon/init")

--Log.steb("Running Carbon Version " .. Carbon.VersionString)
--Log.steb(Carbon.Support:Report())

Game = Game or {}

if (love) then
	require "lua/love"
end

function Game.main()

	--Log.steb("Game.main called")

	--Game.game()

	if (UITweener) then
		UITweener:clear()
	else
		UITweener = Tweener()
	end


    window = window or UiWindow.create("y", 200, 400)
    -- Log.bobn(window)
    -- Log.bobn(window.__coreProperties__)


    window.resizable = false;
    window.collapsable = false;
    window.closable = false;
    window.movable = false;
    window.x = 100;
    window.y = 400;
    window.title = "StebDaBes"

    window.someVar = 3
    window:addText(Parser.getString("TESTKEY"))
    window:addButton("Continue")

		window:addButton("New Game")
		for i=1,100 do
			-- window:addButton("Options")

			-- body...
		end





		-- UITweener:new(8, window, {y = 10}):setEasing(EasingFunctions.outBounce)

		UITweener:new(8, window, {y = 10}):setEasing(EasingFunctions.outBounce)



		UITweener:new(2, window, {x = 500}):addOnComplete(function(uiElement)
				UITweener:new(2, window, {x = 100}):addOnComplete(function(_)
					UITweener:new(2, window, {x = 500}):setEasing("outBounce"):addOnComplete(function(uiElement)
							UITweener:new(2, window, {x = 100}):setEasing("inBounce")
						end)
					end)
				end)

    --[[
    labelA = window.addText("lorum ipsum")
    labelA:setLabel("oh wow")

    buttonA = window.addButton("do a lua function", function()
        Log.bobn("yay")
        window.close()
    end)
    buttonA:setLabel("do a thing")
    buttonA:setCallback(function() Log.bobn("pls") end)

    window = setmetatable({}, {
        __newindex = function(table, key, value)
            if (needForEngineMagic(key)) then

            else
                table[key] = value
            end
        end
    })
    ]]--
end

function Game.update(dt)
	--Log.steb("update the game at dt: " .. tostring(dt))
	dt = dt / 1000
	UITweener:update(dt)
end



function Game.onShutdown()
	Log.steb("Shutting down the game")
end



function Game.onFocusLost()
end

function Game.onFocusGained()
end

function Game.onFileChanged(path)
	local type = nil

	do
		local stringLength = string.len(path)

		type = string.sub(path, stringLength-2)
		path = string.sub(path, 1, stringLength - 4)

		path = string.gsub(path, "\\", "/")
	end

	-- Log.steb("File Changed: " .. tostring(path) .. ", of type: " .. tostring(type))

	if (type == "lua") then
		if (package.loaded[path]) then
			Log.warning("Reloaded lua file: " .. tostring(path))
			package.loaded[path] = nil
			require(path)
		else
			-- Log.steb("Package was not loaded")

		end
	end

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
