
GameStateManager = class(GameStateManager, function(self)

	self._states = {}
	self._transitions = {}

end)


function GameStateManager:addState(state)
	table.insert(self._states, state)
	self._transitions[state] = {}
end

function GameStateManager:addTransition(fromState, transitionType, toState)
	self._transitions[fromState][transition] = toState
end

function GameStateManager:switchState(transitionType)



end
