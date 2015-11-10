-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
function class(c, base, init)
	if (c) then
		if (c.__onReload) then
			local classInstances = c.__instances

			Log.warning("[".. retrieveVariableName(c) .. "] calling __onReload on its " .. #classInstances .. " instances")
			for i=1, #classInstances do
				classInstances[i]:__onReload()
			end
		end
		-- class already exists, assuming we're hotreloading
	else
		c = {} -- a new class instance
	end

	if not init and type(base) == 'function' then
		init = base
		base = nil
	elseif type(base) == 'table' then
		-- our new class is a shallow copy of the base class!
		for i,v in pairs(base) do
			c[i] = v
		end
		c._base = base
	end

	-- the class will be the metatable for all its objects,
	-- and they will look up their methods in it.
	c.__index = c
	c.__instances = setmetatable({}, {__mode = "v"})

	-- expose a constructor which can be called by <classname>(<args>)
	local mt = {}
	mt.__call = function(class_tbl, ...)
		local obj = {}
		setmetatable(obj,c)

		if(base and base.__engineInit) then
			base.__engineInit(obj)
		end

		if init then
			init(obj,...)
		else
			-- make sure that any stuff from the base class is initialized!
			if base and base.init then
				base.init(obj, ...)
			end
		end

		table.insert(c.__instances, obj)

		return obj
	end
	c.init = init
	c.is_a = function(self, klass)
	local m = getmetatable(self)
	while m do
		if m == klass then return true end
			m = m._base
		end
		return false
	end
	setmetatable(c, mt)
	return c
end
