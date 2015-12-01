
GameStateManager = class(GameStateManager, function(self)
	self._states = {}
	self._transitions = {}

	self._currentState = nil
end)

function GameStateManager:update(dt)
	if (self._currentState) then
		self._currentState:baseUpdate(dt)
	end
end

function GameStateManager:addState(state)
	table.insert(self._states, state)
	self._transitions[state] = {}
end

function GameStateManager:addTransition(fromState, transitionType, toState)
	self._transitions[fromState][transitionType] = toState
end

function GameStateManager:doTransition(transitionType, args)
	if (self._currentState) then
		if (self._transitions[self._currentState]) then
			if (self._transitions[self._currentState][transitionType]) then
				self:_setCurrentState(self._transitions[self._currentState][transitionType], transitionType, args)
			else
				Log.warning("Invalid transition: " .. tostring(transitionType))
			end
		else
			Log.warning("")
		end
	else
		Log.warning("")
	end
end

function GameStateManager:_setCurrentState(newState, transitionType, args)
	if (self._currentState) then
		self._currentState:baseExit(transitionType, args)
	end

	self._currentState = newState

	newState:baseEnter(transitionType, args)
end

function GameStateManager:getCurrentState()
	return self._currentState or Log.error("[GameStateManager] tried getting current state, none set!")
end
