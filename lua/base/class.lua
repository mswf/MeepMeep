-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
class = setmetatable(class or {}, {
	__call = function(classTable, c, base, init)
		if (c) then
			table.insert(classTable.__classesToHotreload, c)
		else
			c = {} -- a new class definition
		end

		if not init and type(base) == 'function' then
			init = base
			base = nil
		elseif type(base) == 'table' then
			-- our new class is a shallow copy of the base class!
			-- for i,v in pairs(base) do
			-- 	if (i ~= "__instances") then
			-- 		c[i] = v
			-- 	end
			-- end
			c._base = base
		end

		-- the class will be the metatable for all its objects,
		-- and they will look up their methods in it.
		c.__index = c
		c.__instances = c.__instances or setmetatable({}, {__mode = "v"})
		c.init = init

		-- expose a constructor which can be called by <classname>(<args>)
		local mt = {}
		mt.__index = base
		mt.__tostring = function(class_tbl)
			return "[CLASS] " .. retrieveVariableName(c)
		end


		local initialers = {}
		do
			local currentClass = c
			while (currentClass) do
				table.insert(initialers, rawget(currentClass, "init"))
				currentClass = currentClass._base
			end
		end

		c.__initializers = initialers
		c.__initializersCount = #initialers

		mt.__call = function(class_tbl, ...)
			local obj = {}
			setmetatable(obj,c)

			if(base and base.__engineInit) then
				base.__engineInit(obj)
			end

			local initializers = class_tbl.__initializers
			local initCount = class_tbl.__initializersCount

			for i=initCount,1,-1  do
				initializers[i](obj, ...)
			end

			table.insert(c.__instances, obj)

			return obj
		end
		-- local variableName =
		c.__tostring = function(value) return "[INSTANCE] " .. retrieveVariableName(c) end
		c.__concat = function(op1, op2) return tostring(op1) .. tostring(op2) end
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
})

class.__classesToHotreload = class.__classesToHotreload or {}

class.__hotReloadClasses = function(self)
	local targetClasses = self.__classesToHotreload

	for i=1, #targetClasses do
		if (targetClasses[i].__onReload) then
			local classInstances = targetClasses[i].__instances

			Log.warning("[".. retrieveVariableName(targetClasses[i]) .. "] __onReload() on #" .. #classInstances)
			for i=1, #classInstances do
				if (classInstances[i]) then
					classInstances[i]:__onReload()
				else
					Log.warning("noop")
				end
			end
		end
	end

	self.__classesToHotreload = {}
end
