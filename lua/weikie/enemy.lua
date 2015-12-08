require "lua/weikie/character"

EnemyState = {
	Suicidal	= 0,
	Defensive	= 1,
	Offensive	= 2,
	Idle		= 3
}

Enemy = class(Enemy, Character, function(self)
	self.state = EnemyState.Idle
	Log.waka(self.state)
	self:_loadModel("objects/Rabbit/Rabbit.obj");
	self._base.init(self)
end)

function Enemy:update()
	if self.state == EnemyState.Suicidal then
		Log.waka("SUICII")
	elseif self.state == EnemyState.Defensive then
		Log.waka("DEFEEE")
	elseif self.state == EnemyState.Offensive then
		Log.waka("OFFFFFF")
	elseif self.state == EnemyState.Idle then
		Log.waka("ZZZZ")
	else
		Log.waka("OOOOOOOBBBB")
	end


	self.state = math.random(0, 3)
	self._base.update(self)
end
