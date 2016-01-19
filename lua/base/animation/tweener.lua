
EasingFunctions = require("lua/base/animation/tweentypes")
local KikitoTween = require("lua/base/animation/kikitotween")

Tweener = class(Tweener, function(self)
	self._activeTweens = {}
	self._pausedTweens = {}
end)

function Tweener:__call(...)
	return self:new(...)
end

function Tweener:new(duration, subject, target)
	local newTween = KikitoTween.new(duration, subject, target)
	table.insert(self._activeTweens, newTween)

	return newTween
end

function Tweener:update(dt)
	local activeTweens = self._activeTweens

	local toRemove = {}

	for i=1, #activeTweens do
		local tween = activeTweens[i]
		if (tween:update(dt)) then
			table.insert(toRemove, i)
			tween:complete()
		end
	end

	for i=#toRemove, 1,-1  do
		table.remove(self._activeTweens, toRemove[i])
	end
end

function Tweener:removeActiveTween(tweenToRemove)
	local activeTweens = self._activeTweens

	local toRemove = {}

	for i=1, #activeTweens do
		if (activeTweens[i] == tweenToRemove) then
			activeTweens[i]:complete()
			table.remove(self._activeTweens, i)
			return true
		end
	end

	return false
end

function Tweener:clear()
	self._activeTweens = {}
	self._pausedTweens = {}

end
