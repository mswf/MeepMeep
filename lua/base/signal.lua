

local weakMT = {
	__mode = "kv"
}

Signal = class(Signal, function(self)
	self._callbacks = {
		setmetatable({}, weakMT),
		setmetatable({}, weakMT),
		setmetatable({}, weakMT)
	}
	self._callbacksOnce = {
		setmetatable({}, weakMT),
		setmetatable({}, weakMT),
		setmetatable({}, weakMT)
	}
end)

function Signal:add(callback, context, priority)
	priority = priority or 2
	self._callbacks[priority][context] = callback
end

function Signal:addOnce(callback, context, priority)
	priority = priority or 2
	self._callbacksOnce[priority][context] = callback
end

function Signal:remove(contextToRemove)
	for i=1,3 do
		for context, callback in pairs(self._callbacks[i]) do
			if (context == contextToRemove) then
				self._callbacks[i][context] = nil
				return
			end
		end
	end
end

function Signal:removeOnce(contextToRemove)
	for i=1,3 do
		for context, callback in pairs(self._callbacksOnce[i]) do
			if (context == contextToRemove) then
				self._callbacksOnce[i][context] = nil
				return true
			end
		end
	end
	return false
end

function Signal:removeAll()
	self._callbacks = {
		setmetatable({}, weakMT),
		setmetatable({}, weakMT),
		setmetatable({}, weakMT)
	}
	self._callbacksOnce = {
		setmetatable({}, weakMT),
		setmetatable({}, weakMT),
		setmetatable({}, weakMT)
	}
end

function Signal:__call(...)
	self:dispatch(...)
end

function Signal:dispatch(...)
	local callbacksOnceDirty = false
	for i=1,3 do
		for context, callback in pairs(self._callbacks[i]) do
			callback(context, ...)
		end

		for context, callback in pairs(self._callbacksOnce[i]) do
			callbacksOnceDirty = true
			callback(context, ...)
		end
	end

	if (callbacksOnceDirty) then
		self._callbacksOnce = {
			setmetatable({}, weakMT),
			setmetatable({}, weakMT),
			setmetatable({}, weakMT)
		}
	end
end
