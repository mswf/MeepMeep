


Tween = class(Tween, function(self)
	Log.steb("Created a Tween!")

	self.tween = TweenTypes.linear

	self._onStart = {}
	self._onUpdate = {}
	self._onComplete = {}
end)


function Tween:setEase(self, tweenType)
	self.tween = tweenType
	
	return self
end

function Tween:update(dt)

end

function Tween:start()

end

function Tween:stop()

end

function Tween:pause()

end

function Tween:resume()

end

function Tween:addOnStart(func)

end

function Tween:addOnUpdate(func)

end

function Tween:addOnComplete()

end
