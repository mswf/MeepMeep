
math.randomseed(os.time())

require "lua/application/logging"
require "lua/base/base"
require "lua/application/states/applicationstatemanager"

--local Carbon = require("lua/Carbon/init")
--Log.steb("Running Carbon Version " .. Carbon.VersionString)
--Log.steb(Carbon.Support:Report())

Game = Game or {}

if (love) then
	require "lua/love"
end

function Game.crash()
	noTable["yes"] = 500
end

function Game.main()
	GlobalStateManager = ApplicationStateManager()



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
	dt = dt / 1000

	GlobalStateManager:update(dt)
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

		dotPosition  = string.find(path, "%.")

		type = string.sub(path, dotPosition+1)
		path = string.sub(path, 1, dotPosition-1)

		path = string.gsub(path, "\\", "/")

		local projectStart, projectEnd = string.find(path, "HonkHonk/") or string.find(path, "MeepMeep/")
		-- Mac returns the full filepath
		if (projectStart) then
			Log.steb(projectStart .. " ||| " .. projectEnd)
			Log.steb(projectStart .. " ||| " .. projectEnd)

			path = string.sub(path, projectEnd)
		end
	end

	Log.warning("File Changed: " .. tostring(path) .. ", of type: " .. tostring(type))

	if (type == "lua") then
		if (package.loaded[path]) then
			Log.warning("Reloaded lua file: " .. tostring(path))
			package.loaded[path] = nil
			require(path)
			return true
		else
			-- Log.warning("Package: ".. tostring(path) .. " was not loaded")
			return false
		end
	else
		return false
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
