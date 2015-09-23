
TweenTypes = require("lua/base/animation/tweentypes")
require "lua/base/animation/tween"

Tweener = class(Tweener, function(self)
	Tweener.instance = self
end)

function Tweener.getInstance()
	if (Tweener.instance ~= nil) then
		return Tweener.instance
	else
		return Tweener()
	end
end


function Tweener.delayedCall(func, delay)
	--#TODO:0 implement delayedCall
end
