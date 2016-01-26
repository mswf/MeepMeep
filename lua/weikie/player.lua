require "lua/weikie/character"
require "lua/weikie/projectile"

Player = class(Player, Character, function(self)

end)

function Player:update(dt)
	self:pollInput()
	self._base.update(self, dt)
end

function Player:pollInput()
	if Input.key(KeyCode.w) == true then
		self:moveUp()
	end

	if Input.key(KeyCode.d) == true then
		self:moveLeft()
	end

	if Input.key(KeyCode.s) == true then
		self:moveDown()
	end

	if Input.key(KeyCode.a) == true then
		self:moveRight()
	end

	if Input.keyDown(KeyCode.r) == true then
		self:shoot()
	end
end

function Player:shoot()
	local proj = Projectile()
	proj:setMaterial(ENUM.PROJECTILES[1])
	proj:setPosition(self:getPosition())
	proj:setSpeed(self.horizontalSpeed, self.verticalSpeed)
end
