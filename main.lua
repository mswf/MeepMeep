
succes, profiler = pcall(require, "lua.jit.p")

if not succes then
	print("booboo")
	profiler = {}
	profiler.start = function() print("lol") end
	profiler.stop = function() print("lol") end
end

math.randomseed(os.clock())

profiler.start("init")
require "lua/init"
profiler.stop("init")
