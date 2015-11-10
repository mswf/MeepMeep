Broadcaster = class(Broadcaster, function(self)
	self._events = {}

end)


function Broadcaster:register(owner, event, callback)

	if (not self._events[event]) then
		self._events[event] = setmetatable({}, {
			__mode = "k"
		})
	end

	self._events[event][owner] = callback
end

function Broadcaster:_onReload()
	Log.steb("reloaded")
end

function Broadcaster:unregister(owner, event)
	if (not self._events[event]) then
		Log.warning("Object: " .. tostring(owner) .. " tried to unregiser non registered Event: " .. tostring(event) .. " itself from the broadcaster")
		return
	end

	if (not self._events[event][owner]) then
		Log.warning("Object: " .. tostring(owner) .. " tried to unregister from Event: " .. tostring(event) .. " while no events were registered")
		return
	end
end

function Broadcaster:broadcast(event, params)
	if (not self._events[event]) then
		return
	end

	for object, callback in pairs(self._events[event]) do
		callback(object, params)
	end
end
