
-- metatables to sandbox code #2


--http://lua-users.org/wiki/SandBoxes
local string = string

local env = {
	assert = asset,
	error = error,
	_VERSION = _VERSION,

	tostring = tostring,
	tonumber = tonumber,
	type = type,

	next = next,
	pairs = pairs,
	ipairs = ipairs,

	unpack = unpack,
	select = select,

	pcall = pcall,
	xpcall = xpcall,

	print = Log.steb,
	string = {
		byte = string.byte,
		char = string.char,
		-- find = string.find, -- might lockup CPU, see manual
		format = string.format,
		gmatch = string.gmatch,
		gsub = string.gsub,
		len = string.len,
		lower = string.lower,
		match = string.match,
		rep = string.rep,
		reverse = string.reverse,
		sub = string.sub,
		upper = string.upper
	},
	table = {
		concat = table.concat,
		foreach = table.foreach,
		foreachi = table.foreachi,
		getn = table.getn,
		insert = table.insert,
		maxn = table.maxn,
		remove = table.remove,
		sort = table.sort
	},
	math = {
		abs = math.abs,
		acos  = math.acos,
		asin  = math.asin,
		atan  = math.atan,
		atan2  = math.atan2,
		ceil  = math.ceil,
		cos  = math.cos,
		cosh  = math.cosh,
		deg  = math.deg,
		exp  = math.exp,
		floor  = math.floor,
		fmod  = math.fmod,
		frexp  = math.frexp,
		huge  = math.huge,
		ldexp  = math.ldexp,
		log  = math.log,
		log10  = math.log10,
		max  = math.max,
		min  = math.min,
		modf  = math.modf,
		pi  = math.pi,
		pow  = math.pow,
		rad  = math.rad,
		random  = math.random,
		randomseed  = math.randomseed,
		sin  = math.sin,
		sinh  = math.sinh,
		sqrt  = math.sqrt,
		tan  = math.tan,
		tanh  = math.tanh
	},
	os = {
		clock = os.clock,
		time = os.time

	}
}
env["_G"] = env

local envmeta = { __index={}, __newindex=function() end }
setmetatable(env, envmeta)

function run(code)
	local f = loadstring(code)
	setfenv(f, env)
	pcall(f)
end

run([[
	local x = “Hello, World!”
	print(x)
	local y = string.len(x)
]])
