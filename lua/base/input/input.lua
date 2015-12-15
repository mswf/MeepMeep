
require "lua/base/input/keycode"


Input = Input or {}

Input.InputStates = Input.InputStates or {}

Input.InputStates.default = {
	bindings = {
		moveUp   	=		{KeyCode.w, KeyCode.UP},
		moveDown 	=		{KeyCode.s, KeyCode.DOWN},
		moveLeft 	=		{KeyCode.a, KeyCode.LEFT},
		moveRight	=		{KeyCode.d, KeyCode.RIGHT}
	}
}

function Input._getCurrentInputState()
	return Input.InputStates.default
end

function Input.binding(binding)
	local bindings = Input._getCurrentInputState().bindings[binding] or {}

	for i=1, #bindings do
		if (Input.key(bindings[i])) then
			return true
		end
	end
	return false
end

function Input.bindingDown(binding)
	local bindings = Input._getCurrentInputState().bindings[binding] or {}

	for i=1, #bindings do
		if (Input.keyDown(bindings[i])) then
			return true
		end
	end
	return false
end

function Input.bindingUp(binding)
	local bindings = Input._getCurrentInputState().bindings[binding] or {}

	for i=1, #bindings do
		if (Input.keyUp(bindings[i])) then
			return true
		end
	end
	return false
end
