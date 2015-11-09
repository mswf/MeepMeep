
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

function GameStateManager:doTransition(transitionType)
	if (self._currentState) then
		if (self._transitions[self._currentState]) then
			self._currentState = self._transitions[self._currentState]
		else
			Log.warning("")
		end
	else
		Log.warning("")
	end
end

function GameStateManager:_setCurrentState(newState, transitionType)
	if (self._currentState) then
		self._currentState:exit(transitionType)
	end

	self._currentState = newState

	newState:enter(transitionType)
end
