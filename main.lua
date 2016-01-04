
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

-- profiler.start("F")
require "lua/init"
-- profiler.stop()
