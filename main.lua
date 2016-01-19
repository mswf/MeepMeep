
-- setting up the profiler
local succes = false
profiler = {}

succes, profiler = pcall(require, "jit.p")

if not succes then
	print("Couldn't find the luajit profiler")
	profiler = {}
	profiler.start = function() print("unsuccesfully called profile.start") end
	profiler.stop = function() print("unsuccesfully called profile.stop") end
end

-- setting a random seed
math.randomseed(os.clock())

TINAS_IS_ANGRY = false
if (not TINAS_IS_ANGRY) then
	require "lua/init"
else
	Game = Game or {}
	Game.update = function() end
	Game.main = function() end

	Game.onShutdown = function() end
	Game.onMouseEntered = function() end
	Game.onMouseLeft = function() end
	Game.onMouseGained = function() end
	Game.onMouseLost = function() end
	Game.onWindowResized = function() end
	Game.onFocusLost = function() end
	Game.onFocusGained = function() end
	Game.onWindowMinimized = function() end
	Game.onWindowMaximized = function() end
	Game.onWindowRestored = function() end
	Game.onWindowShown = function() end
	Game.onWindowHidden = function() end
end
-- profiler.start("F")
-- profiler.stop()
